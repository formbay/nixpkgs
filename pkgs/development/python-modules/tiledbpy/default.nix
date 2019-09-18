{ lib
, pytest-dependency
, buildPythonPackage
, fetchPypi
, fetchFromGitHub
, setuptools_scm
, tiledb
, numpy
, wheel
#, cmake
}:

buildPythonPackage rec {
  pname = "tiledb";
  version = "0.4.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "bda0ef48e6a44c091399b12ab4a7e580d2dd8294c222b301f88d7d57f47ba142";
  };
  
#  src = fetchFromGitHub {
#    owner = "TileDB-Inc";
#    repo = "TileDB-Py";    
#    rev = "0.4.3";   
#    sha256 = "sha256:16hdz2d5d4llrq3l08a846yx4s71i780irhak041vjn1j1n3wmz6";
#  };

  nativeBuildInputs = [
    setuptools_scm
    numpy
    wheel
    tiledb
#    cmake
  ];

  propagatedBuildInputs = [
    pytest-dependency
  ];

# installPhase = ''make install-tiledb'';
#  checkPhase = ''pytest'';
#  checkInputs = [
#    tiledb
#  ];

#  doCheck = false;

  meta = with lib; {
    description = "TileDB-Py is the official Python interface to TileDB";
    homepage = https://github.com/TileDB-Inc/TileDB-Py;
    license = licenses.mit;
    maintainers = with maintainers; [ rakesh4g ];
  };
}
