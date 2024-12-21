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
      "llama3"
      "mannix/llama3.1-8b-abliterated"
    ];
  };
}
