class BasicMemory < Formula
  desc "AI-powered knowledge management system with MCP server integration"
  homepage "https://github.com/basicmachines-co/basic-memory"
  url "https://github.com/basicmachines-co/basic-memory/archive/refs/tags/v0.13.5.tar.gz"
  sha256 "61caf0d4b3991d46aa67d36b1224fbaacbe411076f27a2a19535740627fbd19c"
  license "MIT"
  head "https://github.com/basicmachines-co/basic-memory.git", branch: "main"

  depends_on "node"
  depends_on "python@3.11"

  def install
    # Install Node.js dependencies
    system "npm", "install", *Language::Node.std_npm_args(libexec)

    # Install Python dependencies
    virtualenv_install_with_resources

    # Create bin symlinks
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Install any additional files
    # Adjust paths based on actual project structure
    share.install "config" if File.exist?("config")
    share.install "templates" if File.exist?("templates")
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
