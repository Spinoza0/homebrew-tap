class OllamaScripts < Formula
  desc "Bash scripts to manage Ollama on macOS (Homebrew)"
  homepage "https://github.com/Spinoza0/ollama-scripts"
  url "https://github.com/Spinoza0/ollama-scripts/archive/refs/tags/v1.1.tar.gz"
  sha256 "f8d0503b35769077c253f684fb85bb533400ab4bbb3ad24d2a9407a1be4e5a11"

  depends_on :macos

  def install
    bin.install "install.sh", "download-model.sh", "run-chat.sh", "run-server.sh",
                "stop.sh", "status.sh", "uninstall.sh", "lib.sh", "config.env"
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

      Configuration (model, host, port, keep-alive) lives in the installed
        config.env — edit it to change defaults.
    EOS
  end
end