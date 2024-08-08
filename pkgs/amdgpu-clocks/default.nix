{
  stdenv,
  lib,
  fetchFromGitHub,
  bash,
  subversion,
  makeWrapper,
}:
stdenv.mkDerivation {
  pname = "amdgpu-clocks";
  version = "973139a";
  src = fetchFromGitHub {
    # https://github.com/sibradzic/amdgpu-clocks
    owner = "sibradzic";
    repo = "amdgpu-clocks";
    rev = "973139a5933bd315aa99332b642305ef5ef49a32";
    sha256 = "sha256-mZV4ECNG9X6SDIWl6P0nHrxa4kGU1h/hFdMcswbEYrk=";
  };
  buildInputs = [bash subversion];
  nativeBuildInputs = [makeWrapper];
  installPhase = ''
    mkdir -p $out/bin
    cp amdgpu-clocks $out/bin/amdgpu-clocks
    wrapProgram $out/bin/amdgpu-clocks \
      --prefix PATH : ${lib.makeBinPath [bash subversion]}
  '';
}
