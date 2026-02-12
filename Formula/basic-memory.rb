class BasicMemory < Formula
  desc "AI-powered knowledge management system with MCP server integration"
  homepage "https://github.com/basicmachines-co/basic-memory"
  url "https://github.com/basicmachines-co/basic-memory/archive/refs/tags/v0.18.3.tar.gz"
  sha256 "d0cd4adc5a5e0746f54fa34b97a7fd3734f000d4a1bb8e2704bde598e4c39327"
  license "AGPL-3.0-or-later"
  head "https://github.com/basicmachines-co/basic-memory.git", branch: "main"

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

  def caveats
    <<~EOS
      Basic Memory has been installed as a command-line tool.
      
      To get started:
        basic-memory --help
      
      For use with Claude Desktop, add to your claude_desktop_config.json:
        https://memory.basicmachines.co/integrations/claude-desktop
    EOS
  end

  test do
    # Basic test to ensure the binary works
    system bin/"basic-memory", "--version"
  end
end
