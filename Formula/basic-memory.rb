class BasicMemory < Formula
  desc "AI-powered knowledge management system with MCP server integration"
  homepage "https://github.com/basicmachines-co/basic-memory"
  url "https://github.com/basicmachines-co/basic-memory/archive/refs/tags/v0.13.7.tar.gz"
  sha256 "309d5d1f1090d6b196b5e2fd05ef4b0b15a7baf509004a60f0c7cddbe7f781a1"
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

  service do
    run [opt_bin/"basic-memory", "serve"]
    keep_alive true
    log_path var/"log/basic-memory.log"
    error_log_path var/"log/basic-memory.log"
  end

  test do
    # Basic test to ensure the binary works
    system bin/"basic-memory", "--version"
  end
end
