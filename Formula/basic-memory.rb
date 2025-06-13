class BasicMemory < Formula
  desc "AI-powered knowledge management system with MCP server integration"
  homepage "https://github.com/basicmachines-co/basic-memory"
  url "https://github.com/basicmachines-co/basic-memory/archive/refs/tags/v0.13.5.tar.gz"
  sha256 "61caf0d4b3991d46aa67d36b1224fbaacbe411076f27a2a19535740627fbd19c"
  license "AGPL-3.0-or-later"
  head "https://github.com/basicmachines-co/basic-memory.git", branch: "main"

  depends_on "python@3.12"

  def install
    python3 = "python3.12"
    venv = virtualenv_create(libexec, python3)
    
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "."
    
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
