{ ... }:

{
  # Get up and running with large language models locally.
  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };
}
