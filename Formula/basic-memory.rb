class BasicMemory < Formula
  desc "AI-powered knowledge management system with MCP server integration"
  homepage "https://github.com/basicmachines-co/basic-memory"
  url "https://github.com/basicmachines-co/basic-memory/archive/refs/tags/v0.23.2.tar.gz"
  sha256 "382db506e81877b3235f6b51c04e1a2480bbc235eca65ba846734dbfa61cee63"
  license "AGPL-3.0-or-later"
  head "https://github.com/basicmachines-co/basic-memory.git", branch: "main"

  depends_on "rust" => :build
  depends_on "uv" => :build

  def install
    # Install Python and basic-memory using uv
    ENV["UV_PYTHON_PREFERENCE"] = "only-managed"
    ENV["UV_PYTHON_INSTALL_DIR"] = libexec/"python"
    ENV["UV_TOOL_DIR"] = libexec/"tools"
    ENV["UV_TOOL_BIN_DIR"] = libexec/"bin"
    
    # Note: We don't set SETUPTOOLS_SCM_PRETEND_VERSION here because
    # we're installing from PyPI (pre-built), not building from source.
    # Setting it would leak into dependency builds (e.g., lazy-object-proxy)
    # causing version metadata mismatches.
    
    # Install basic-memory as a uv tool from PyPI with exact version
    system "uv", "tool", "install", "basic-memory==#{version}", "--no-cache"
    
    # Create symlinks to the executables
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  def post_install
    # Homebrew runs `fix_dynamic_linkage` after `install` but before
    # `post_install`. For every bundled Python extension module it rewrites
    # LC_ID_DYLIB through ruby-macho (e.g. protobuf's `_message.abi3.so`, whose
    # upstream ID is still a `bazel-out/...` build path) and then writes the
    # file back without re-signing it -- `codesign_patched_binaries` is only
    # wired into the text-relocation path, not this one.
    #
    # That leaves the ad-hoc signature the wheels ship with no longer matching
    # the file contents. On Apple Silicon the kernel refuses to load such a
    # Mach-O and SIGKILLs the process, so every `bm`/`basic-memory` invocation
    # died with exit 137 and no output at all -- not even a Python traceback,
    # because the process is killed during `dlopen`.
    #
    # Re-sign the bundled Mach-O files here, after relocation has run.
    return unless Hardware::CPU.arm?

    Dir.glob(libexec/"**/*.{so,dylib}").each do |file|
      next if quiet_system("codesign", "--verify", file)

      system "codesign", "--force", "--sign", "-", file
    end
  end

  def caveats
    <<~EOS
      Basic Memory has been installed as a command-line tool.
      
      To get started:
        basic-memory --help
      
      For use with Claude Desktop, add to your claude_desktop_config.json:
        https://memory.basicmachines.co/integrations/claude-desktop

      Homebrew 6 will require explicit trust for third-party taps before
      installing or upgrading from them. To keep upgrades working:
        brew trust basicmachines-co/basic-memory
    EOS
  end

  test do
    # Basic test to ensure the binary works
    system bin/"basic-memory", "--version"
  end
end
