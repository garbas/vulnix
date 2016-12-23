{ pkgs ? import (builtins.fetchTarball "https://d3g5gsiof5omrk.cloudfront.net/nixos/16.09/nixos-16.09.1324.1dd0fb6/nixexprs.tar.xz") {}
, pypi2nix ? null
}:

let
  pypi2nix' =
    if pypi2nix == null
      then "${pkgs.pypi2nix}/bin/pypi2nix"
      else pypi2nix;
in pkgs.stdenv.mkDerivation {
  name = "update-vulnix";
  buildCommand = ''
    echo "+--------------------------------------------------------+"
    echo "| Not possible to update vulnix using \`nix-build\`. |"
    echo "|         Please run \`nix-shell update.nix\`.             |"
    echo "+--------------------------------------------------------+"
    exit 1
  '';
  shellHook = ''
    export HOME=$PWD
    ${pypi2nix'} -V 3.5 \
            -b buildout.cfg \
            -E "libxml2 libxslt" \
            -e pytest-runner \
            -e setuptools-scm \
            -v
    echo "Vulnix updated!"
    exit 0
  '';
}
