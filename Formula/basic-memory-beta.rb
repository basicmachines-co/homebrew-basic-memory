class BasicMemoryBeta < Formula
  desc "AI-powered knowledge management system with MCP server integration (beta/pre-release)"
  homepage "https://github.com/basicmachines-co/basic-memory"
  # This is a placeholder URL - the actual version will be specified at install time
  url "https://github.com/basicmachines-co/basic-memory.git", branch: "main"
  license "AGPL-3.0-or-later"
  
  depends_on "rust" => :build
  depends_on "uv" => :build

  def install
    # Get the version from BM_VERSION environment variable
    version = ENV["BM_VERSION"]
    
    unless version
      odie <<~EOS
        You must specify a version to install!
        
        Usage:
          BM_VERSION=0.13.8b1 brew install basic-memory-beta
          BM_VERSION=0.13.8rc1 brew install basic-memory-beta
          BM_VERSION=0.13.8.dev1 brew install basic-memory-beta
        
        Available versions can be found at:
          https://pypi.org/project/basic-memory/#history
      EOS
    end
    
    # Install Python and basic-memory using uv
    ENV["UV_PYTHON_PREFERENCE"] = "only-managed"
    ENV["UV_PYTHON_INSTALL_DIR"] = libexec/"python"
    ENV["UV_TOOL_DIR"] = libexec/"tools"
    ENV["UV_TOOL_BIN_DIR"] = libexec/"bin"
    
    # Set the version to prevent dev version issues
    ENV["SETUPTOOLS_SCM_PRETEND_VERSION"] = version
    
    # Install basic-memory as a uv tool from PyPI with exact version
    # For pre-releases, we need to add --pre flag
    system "uv", "tool", "install", "basic-memory==#{version}", "--pre", "--no-cache"
    
    # Create symlinks to the executables
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  def post_install
    # Same as the stable formula: Homebrew's `fix_dynamic_linkage` rewrites
    # LC_ID_DYLIB in the bundled Mach-O files after `install` and writes them
    # back without re-signing, which invalidates the ad-hoc signature the wheels
    # ship with. On Apple Silicon the kernel then SIGKILLs any process that
    # loads one, so `bm`/`basic-memory` exits 137 with no output. This formula
    # installs the same wheels through the same `uv tool install`, so it is
    # affected identically. See Formula/basic-memory.rb for the full write-up.
    # macOS-only: `codesign` does not exist on other platforms, and
    # `Hardware::CPU.arm?` is true on ARM Linux too -- where the glob would
    # find Linux `.so` files, `codesign` would be missing, and the `system`
    # call below would abort `post_install` and fail the whole install.
    return unless OS.mac?
    return unless Hardware::CPU.arm?

    Dir.glob(libexec/"**/*.{so,dylib}", File::FNM_DOTMATCH).each do |file|
      next if quiet_system("codesign", "--verify", file)

      system "codesign", "--force", "--sign", "-", file
    end
  end

  def caveats
    <<~EOS
      Basic Memory BETA has been installed as a command-line tool.
      
      This is a pre-release version and may contain bugs or incomplete features.
      Version installed: #{ENV["BM_VERSION"] || "unknown"}
      
      To get started:
        basic-memory --help
      
      For use with Claude Desktop, add to your claude_desktop_config.json:
        https://memory.basicmachines.co/integrations/claude-desktop
      
      To install a different beta version:
        brew uninstall basic-memory-beta
        BM_VERSION=x.y.z brew install basic-memory-beta
      
      To install the stable version instead:
        brew uninstall basic-memory-beta
        brew install basic-memory
    EOS
  end

  test do
    # Basic test to ensure the binary works
    system bin/"basic-memory", "--version"
  end
end