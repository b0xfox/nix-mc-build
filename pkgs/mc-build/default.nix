{
  pkgs,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage {

  pname = "mc-build";
  version = "4.1.3";

  src = fetchFromGitHub {
    owner = "mc-build";
    repo = "mcb";
    rev = "7865a1049b477af581cdefc8d2a23096186f68fd";
    hash = "sha256-BSvagLFasjSVHKrX4+rcIx9HON1iqQufj9VVnkV4vK4=";
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
