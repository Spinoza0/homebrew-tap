class ClaudeClineProxy < Formula
  include Language::Python::Virtualenv

  desc "Run Claude Code CLI through any Cline provider via a local API proxy"
  homepage "https://github.com/Spinoza0/claude-cline-proxy"
  url "https://github.com/Spinoza0/claude-cline-proxy/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "78d0b9952f1d748bf9c8344f8c89a69686e5eaf863d7af8e2848dc4cfd23eb0a"

  depends_on "python@3"

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install "aiohttp"

    bin.install "claude-cline.sh" => "claude-cline"
    libexec.install "claude-cline-proxy.py"
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
