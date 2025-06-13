class BasicMemory < Formula
  desc "AI-powered knowledge management system with MCP server integration"
  homepage "https://github.com/basicmachines-co/basic-memory"
  url "https://github.com/basicmachines-co/basic-memory/archive/refs/tags/v0.13.5.tar.gz"
  sha256 "61caf0d4b3991d46aa67d36b1224fbaacbe411076f27a2a19535740627fbd19c"
  license "AGPL-3.0-or-later"
  head "https://github.com/basicmachines-co/basic-memory.git", branch: "main"

  depends_on "uv" => :build

  def install
    # Use uv to create a virtual environment with its own Python
    ENV["UV_PYTHON_PREFERENCE"] = "only-managed"
    ENV["UV_CACHE_DIR"] = buildpath/".uv_cache"
    
    venv = libexec/"venv"
    system "uv", "venv", venv, "--python", "3.12"
    
    # Install basic-memory into the virtual environment
    system "uv", "pip", "install", "--python", venv/"bin/python", "."
    
    # Create wrapper scripts that use the venv
    (bin/"basic-memory").write_env_script venv/"bin/basic-memory",
      PATH: "#{venv}/bin:$PATH"
    (bin/"bm").write_env_script venv/"bin/bm",
      PATH: "#{venv}/bin:$PATH"
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
