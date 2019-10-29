{ lib
, buildPythonPackage
, fetchPypi
, requests
, jinja2
, pillow
, rasterio
, shapely
}:

buildPythonPackage rec {
  pname = "labelbox";
  version = "2.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "a2fdfb0e747747f21e853a1dfdf14d3332129d74e8a6485f81b82cf543908f6c";
  };

  propagatedBuildInputs = [ jinja2 requests pillow rasterio shapely ];

  # Test cases are not running on pypi or GitHub
  doCheck = false;   

  meta = with lib; {
    homepage = https://github.com/Labelbox/Labelbox;
    description = "Platform API for LabelBox";
    license = licenses.asl20;
    maintainers = with maintainers; [ rakesh4g ];
  };
}
