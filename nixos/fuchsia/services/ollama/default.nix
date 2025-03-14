{...}: {
  # Get up and running with large language models locally.
  services.ollama = {
    enable = true;

    # AMD GPU Support
    acceleration = "rocm";
    # 5700xt Support
    rocmOverrideGfx = "10.1.0";

    # Language models to install
    loadModels = [
      "deepseek-coder-v2"
      # these were dependencies for continue.dev
      # but idk if i'll end up using it
      # for now we shall keep them
      "llama3.1:8b"
      "qwen2.5-coder:1.5b-base"
      "nomic-embed-text:latest"
    ];
  };
}
