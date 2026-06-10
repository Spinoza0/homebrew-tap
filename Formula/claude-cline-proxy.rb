class ClaudeClineProxy < Formula
  desc "Run Claude Code CLI through any Cline provider via a local API proxy"
  homepage "https://github.com/Spinoza0/claude-cline-proxy"
  url "https://github.com/Spinoza0/claude-cline-proxy/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "65593f400a231ea01b12ff889363d27c08aea648a1aa180e4845b2d46ba9e700"

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

      Select a provider interactively (skipped when --model or --provider is used):
        claude-cline

      Override provider or model:
        claude-cline --model deepseek/deepseek-v4-flash -p "hi"
        claude-cline --provider openrouter --model qwen/qwen3-coder:free

      To enable debug logging:
        CLAUDE_PROXY_LOG=1 claude-cline "your prompt here"

      Your Cline provider is read dynamically from ~/.cline/data/settings/providers.json.
      Model overrides from IDE plugins (globalState.json) are applied automatically.
    EOS
  end
end
