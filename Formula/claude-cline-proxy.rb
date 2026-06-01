class ClaudeClineProxy < Formula
  desc "Run Claude Code CLI through any Cline provider via a local API proxy"
  homepage "https://github.com/Spinoza0/claude-cline-proxy"
  url "https://github.com/Spinoza0/claude-cline-proxy/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "8774951216c758952997025ea78274b8b773bbbc07cee03f388219fad6797320"

  depends_on "python@3"

  def install
    system "python3", "-m", "venv", "--clear", libexec/"venv"
    system libexec/"venv/bin/python3", "-m", "pip", "install", "-q", "aiohttp"

    bin.install "claude-cline.sh" => "claude-cline"
    libexec.install "claude-cline-proxy.py", "claude-cline-select.py"
    etc.install "claude-cline-mcp.json"
    doc.install "README.md", "AGENTS.md"
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
