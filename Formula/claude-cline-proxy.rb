class ClaudeClineProxy < Formula
  desc "Run Claude Code CLI through any Cline provider via a local API proxy"
  homepage "https://github.com/Spinoza0/claude-cline-proxy"
  url "https://github.com/Spinoza0/claude-cline-proxy/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "680be93cb4fd4e3424d81046ac5ba7ddf75466ff7fc9cc07645ae6b4adac6836"

  depends_on "python@3"

  def install
    bin.install "claude-cline.sh" => "claude-cline"
    libexec.install "claude-cline-proxy.py"
    etc.install "claude-cline-mcp.json"
    doc.install "README.md", "AGENTS.md"
  end

  def post_install
    system "pip3", "install", "aiohttp"
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
