{
  pkgs,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage {

  pname = "mc-build";
  version = "4.1.1";

  src = fetchFromGitHub {
    owner = "mc-build";
    repo = "mcb";
    rev = "031f6d411b54e2e6f79b9543f15a1ed876408a0f";
    hash = "sha256-MZAiEy/cYvKIE3gKGyL0f6BoWO/swiPf2U3LF7/i18g=";
  };

  npmDepsHash = "sha256-/Rs7wvb7FhZ/CIxlwg/4Wwn8I3snqvk552rkH5qG7hw=";
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
