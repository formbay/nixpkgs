{ lib
, buildPythonPackage
, fetchPypi
#, modestmaps
, pillow
#, pycairo
#, python-mapnik
#, simplejson
#, werkzeug
#, isPy27
, pyyaml
, pyproj
, pytest
, lxml
, requests
, shapely
#, gdal_2
}:

buildPythonPackage rec {
  pname = "MapProxy";
  version = "1.12.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1v72d1svx1vn5cdg1wza0dgxf04dq54in8s23si1p1pgjrvklbk2";
  };

  propagatedBuildInputs = [ pyyaml pillow pytest lxml pyproj requests shapely ];

#  installPhase = ''make install'';
  check = false;
  checkInputs = [ pytest pyproj ];
  meta = with lib; {
    description = "MapProxy is an open source proxy for geospatial data";
    homepage = https://mapproxy.org/;
    license = licenses.asl20;
  };

}

