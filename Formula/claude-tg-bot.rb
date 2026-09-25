class ClaudeTgBot < Formula
  desc "Run Claude Code via a Telegram userbot"
  homepage "https://github.com/Spinoza0/claude-tg-bot"
  url "https://github.com/Spinoza0/claude-tg-bot/archive/refs/tags/v0.7.7.tar.gz"
  sha256 "ce98d0d8bdc03379f5de80ff69e1d3caa34ad60b975fdb2adea9ec715b26df5a"

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