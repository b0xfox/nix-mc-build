{
  pkgs,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage {

  pname = "mc-build";
  version = "4.3.1";

  src = fetchFromGitHub {
    owner = "mc-build";
    repo = "mcb";
    rev = "ee41ca6c6640771e7a378ba90f31c2101bc63819";
    hash = "sha256-gB1pITl/9eeHdA5sTthGiCLC/zwGiSzAvCkTO9KwuNg=";
  };

  npmDepsHash = "sha256-4AcuEbi0TTqNrHHgyytHIQLK9ZL3C56GsY0gikCmTec=";
  npmBuildScript = "dist";

  postInstall = ''
    mkdir -p $out/bin

    makeWrapper ${pkgs.nodejs}/bin/node $out/bin/mcb \
      --add-flags "$out/lib/node_modules/mc-build/dist/mcb.js"

    ln -sf $out/bin/mcb $out/bin/mc-build
  '';

  meta = {
    description = "A language for creating minecraft datapacks";
    homepage = "https://github.com/mc-build/mcb";
    license = pkgs.lib.licenses.mit;
    mainProgram = "mcb";
  };
}
