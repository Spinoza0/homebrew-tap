class OllamaScripts < Formula
  desc "Bash scripts to manage Ollama on macOS (Homebrew)"
  homepage "https://github.com/Spinoza0/ollama-scripts"
  url "https://github.com/Spinoza0/ollama-scripts/archive/refs/tags/v1.2.tar.gz"
  sha256 "2a7dd1546d01ba00e448fb46a41e5fdedccb256b6a855a79a3dc4d2fa2eee1a3"

  depends_on :macos

  def install
    bin.install "install.sh", "download-model.sh", "run-chat.sh", "run-server.sh",
                "stop.sh", "status.sh", "uninstall.sh", "lib.sh"
    (etc/"ollama-scripts").install "config.env"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      Available commands:
        install.sh          Install Ollama via Homebrew
        download-model.sh   Download the default model (qwen3.8:27b-mlx)
        run-chat.sh         Interactive chat with auto service start/stop
        run-server.sh       Start the API server
        stop.sh             Stop the server
        status.sh           Show server status
        uninstall.sh        Remove Ollama and all models

      Configuration (model, host, port, keep-alive) lives in:
        #{etc}/ollama-scripts/config.env
      The file is preserved across reinstalls/upgrades. Override the location
      with the OLLAMA_SCRIPTS_CONFIG environment variable if needed.
    EOS
  end
end