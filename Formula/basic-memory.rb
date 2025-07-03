class BasicMemory < Formula
  desc "AI-powered knowledge management system with MCP server integration"
  homepage "https://github.com/basicmachines-co/basic-memory"
  url "https://github.com/basicmachines-co/basic-memory/archive/refs/tags/v0.14.2.tar.gz"
  sha256 "992f60549cd8651bf71c80f3cbdc465d797a5bd0ed8f296c82bf8f766c770c41"
  license "AGPL-3.0-or-later"
  head "https://github.com/basicmachines-co/basic-memory.git", branch: "main"

  depends_on "uv" => :build

  def install
    # Install Python and basic-memory using uv
    ENV["UV_PYTHON_PREFERENCE"] = "only-managed"
    ENV["UV_PYTHON_INSTALL_DIR"] = libexec/"python"
    ENV["UV_TOOL_DIR"] = libexec/"tools"
    ENV["UV_TOOL_BIN_DIR"] = libexec/"bin"
    
    # Disable git-based versioning to prevent dev versions
    ENV["SETUPTOOLS_SCM_PRETEND_VERSION"] = version.to_s
    
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
