class OllamaScripts < Formula
  desc "Bash scripts to manage Ollama on macOS (Homebrew)"
  homepage "https://github.com/Spinoza0/ollama-scripts"
  url "https://github.com/Spinoza0/ollama-scripts/archive/refs/tags/v1.3.tar.gz"
  sha256 "4f36dd6c3e8d07327e6b6c0d76b5e057fb3e784c173f0d0916462dc6439c7f4a"

  depends_on :macos

  def install
    bin.install "install.sh" => "ollama-install"
    bin.install "download-model.sh" => "ollama-download-model"
    bin.install "run-chat.sh" => "ollama-run-chat"
    bin.install "run-server.sh" => "ollama-run-server"
    bin.install "stop.sh" => "ollama-stop"
    bin.install "status.sh" => "ollama-status"
    bin.install "uninstall.sh" => "ollama-uninstall"
    bin.install "lib.sh"
    (etc/"ollama-scripts").install "config.env"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      Available commands (prefixed with ollama- to avoid clashes with other formulae):
        ollama-install           Install Ollama via Homebrew
        ollama-download-model    Download the default model (qwen3.8:27b-mlx)
        ollama-run-chat          Interactive chat with auto service start/stop
        ollama-run-server        Start the API server
        ollama-stop              Stop the server
        ollama-status            Show server status
        ollama-uninstall         Remove Ollama and all models

      Configuration (model, host, port, keep-alive) lives in:
        #{etc}/ollama-scripts/config.env
      The file is preserved across reinstalls/upgrades. Override the location
      with the OLLAMA_SCRIPTS_CONFIG environment variable if needed.
    EOS
  end
end