class ClaudeClineProxy < Formula
  desc "Run Claude Code CLI through any Cline provider via a local API proxy"
  homepage "https://github.com/Spinoza0/claude-cline-proxy"
  url "https://github.com/Spinoza0/claude-cline-proxy/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "13c0357db53196e9b1f2374c54c4335daf2b0c9a8f50e8e49a28fe90254ad054"

  depends_on "python@3"

  resource "aiohttp" do
    url "https://files.pythonhosted.org/packages/f1/d9/1c4721d143e14af753f2bf5e3b681883e1f24b592c0482df6fa6e33597fa/aiohttp-3.11.16.tar.gz"
    sha256 "16f8a2c9538c14a557b4d309ed4d0a7c60f0253e8ed7b6c9a2859a7582f8b1b8"
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
