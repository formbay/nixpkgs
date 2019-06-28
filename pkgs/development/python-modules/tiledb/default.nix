buildPythonPackage rec {
  pname = "tiledb";
  version = "0.4.2";

  format = "wheel";

  src = fetchPypi {
    inherit pname version format;
    sha256 = "bda0ef48e6a44c091399b12ab4a7e580d2dd8294c222b301f88d7d57f47ba142";
  };

  LC_ALL = "en_US.UTF-8";
  checkInputs = [ glibcLocales ];
