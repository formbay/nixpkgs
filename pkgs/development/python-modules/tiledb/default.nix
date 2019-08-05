{  pkgs ? import ./pkgs.nix  }:
with pkgs;
let
  python = python36;
 
  tiledb  = import ./tiledb.nix { inherit pkgs; };

in
  python.pkgs.buildPythonPackage rec {
    inherit python;

    pname = "tiledb";
    version = "0.4.2";

    src = pkgs.fetchFromGitHub {
      owner = "TileDB-Inc";
      repo = "TileDB-Py";
      rev = "02d95460905b09765dd34de3786fdf1a8ebc1ce7";
      sha256 = "sha256:1g9b55dk9zz10zihigq0ixh57aa0kb38f2ds7kk394vmjh4i7vhc";
  };

  nativeBuildInputs = with python.pkgs; [cmake setuptools_scm numpy cython];
  propagatedBuildInputs = with python.pkgs; [ tiledb];

  doCheck = false;
  }
