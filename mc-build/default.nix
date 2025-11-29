{
  pkgs,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage {

  pname = "mc-build";
  version = "4.0.2";

  src = fetchFromGitHub {
    owner = "mc-build";
    repo = "mcb";
    rev = "9c13d60e590bd5b195734ba0e2d102829c24062d";
    hash = "sha256-EJpw2WloGE2m5JZiuLT3VwK9d7md48hUUqXyoJK+L1w=";
  };

  npmDepsHash = "sha256-OkLYQ64FwpW/x9nQZsHtCo1mSnyNl8uqKOWxhTybUhA=";
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
