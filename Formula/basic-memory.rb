class BasicMemory < Formula
  desc "AI-powered knowledge management system with MCP server integration"
  homepage "https://github.com/basicmachines-co/basic-memory"
  url "https://github.com/basicmachines-co/basic-memory/archive/refs/tags/v0.13.5.tar.gz"
  sha256 "61caf0d4b3991d46aa67d36b1224fbaacbe411076f27a2a19535740627fbd19c"
  license "AGPL-3.0-or-later"
  head "https://github.com/basicmachines-co/basic-memory.git", branch: "main"

  depends_on "uv" => :build

  def install
    # Install Python and basic-memory using uv
    ENV["UV_PYTHON_PREFERENCE"] = "only-managed"
    ENV["UV_PYTHON_INSTALL_DIR"] = libexec/"python"
    ENV["UV_TOOL_DIR"] = libexec/"tools"
    ENV["UV_TOOL_BIN_DIR"] = libexec/"bin"
    
    # Install basic-memory as a uv tool
    system "uv", "tool", "install", "--from", buildpath.to_s, "basic-memory"
    
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
