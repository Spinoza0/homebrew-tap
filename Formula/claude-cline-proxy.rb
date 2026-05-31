class ClaudeClineProxy < Formula
  desc "Run Claude Code CLI through any Cline provider via a local API proxy"
  homepage "https://github.com/Spinoza0/claude-cline-proxy"
  url "https://github.com/Spinoza0/claude-cline-proxy/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "2dda1619dad561c437990011a04ff0cb1c7ada187d70756e6eb43919808fd2de"

  depends_on "python@3"

  resource "aiohttp" do
    url "https://files.pythonhosted.org/packages/8f/ed/22f2eb6c147499535ddfd439172aee071c2e5da2bee633cfabd1338baeb3/aiohttp-3.11.16.tar.gz"
    sha256 "fa1455f6d469c21e098b2195a2424f8e7cb31b2b089b70e2c2df84a83af1fff8"
  end

  def install
    bin.install "claude-cline.sh" => "claude-cline"
    libexec.install "claude-cline-proxy.py"
    etc.install "claude-cline-mcp.json"
    doc.install "README.md", "AGENTS.md"

    venv = libexec/"venv"
    (libexec/"venv").mkpath
    system "python3", "-m", "venv", venv
    venv_python = venv/"bin/python3"
    resource("aiohttp").stage do
      system venv_python, "-m", "pip", "install", "."
    end
    (libexec/"bin").install Dir["#{venv}/bin/*"]
  end

  def caveats
    <<~EOS
      To use Claude Code with this proxy:
        claude-cline "your prompt here"

      To enable debug logging:
        CLAUDE_PROXY_LOG=1 claude-cline "your prompt here"

      Your Cline provider is read dynamically from ~/.cline/data/settings/providers.json.
      No manual configuration is needed.
    EOS
  end
end
