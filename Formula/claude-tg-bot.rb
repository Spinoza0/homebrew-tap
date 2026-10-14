class ClaudeTgBot < Formula
  desc "Run Claude Code via a Telegram userbot"
  homepage "https://github.com/Spinoza0/claude-tg-bot"
  url "https://github.com/Spinoza0/claude-tg-bot/archive/refs/tags/v0.10.9.tar.gz"
  sha256 "0226be6b76689ed0eee452e7da71f7f47ff671170e9e653bfbe480eb55958bca"

  depends_on "python@3"

  def install
    # Put the source tree into libexec so the launch script resolves its venv,
    # lib/env.sh and requirements.txt relative to itself. The bin wrappers exec
    # from libexec, so $PROJECT_DIR points at the real install dir.
    libexec.install Dir["*"]
    (bin/"claude-tg-bot").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/claude-tg-bot" "$@"
    EOS
    (bin/"claude-tg-bot-setup").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/claude-tg-bot-setup" "$@"
    EOS
    chmod 0755, bin/"claude-tg-bot"
    chmod 0755, bin/"claude-tg-bot-setup"
  end

  def caveats
    <<~EOS
      Configure the bot (interactive setup, creates ~/.claude-tg-bot/config.env):
        claude-tg-bot-setup
      Then launch it:
        claude-tg-bot
    EOS
  end
end