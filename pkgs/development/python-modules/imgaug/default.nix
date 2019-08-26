{ stdenv, buildPythonPackage, fetchPypi, numpy, scipy, scikitimage, opencv3, six, imageio, shapely }:

buildPythonPackage rec {
  pname = "imgaug";
  version = "0.2.9";

  src = fetchPypi {
    inherit pname version;
    sha256 = "42b0c4c8cbe197d4f5dbd33960a1140f8a0d9c22c0a8851306ecbbc032092de8";
  };

  installPhase = ''
    substituteInPlace requirements.txt \
      --replace "opencv-python" "opencv>=3.4.7"
    substituteInPlace setup.py \
      --replace "opencv-python" "opencv>=3.4.7"
  '';

  propagatedBuildInputs = [
    numpy
    scipy
    scikitimage
    opencv3
    six
    imageio
    shapely
  ];

  # disable tests when there are no tests in the PyPI archive
  doCheck = false;

  meta = with stdenv.lib; {
    homepage = https://github.com/aleju/imgaug;
    description = "Image augmentation for machine learning experiments";
    license = licenses.mit;
    maintainers = with maintainers; [ cmcdragonkai ];
#    broken = true; # opencv-python bindings aren't available yet, and look non-trivial
  };
}
