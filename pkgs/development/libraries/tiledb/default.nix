{
lib
,stdenv
,fetchgit
,cmake
,zlib
,lz4
,bzip2
,zstd
,spdlog_0
,tbb
,openssl
,boost
,libpqxx
,clang-tools
,catch2
,python
,gtest
,doxygen
}:

stdenv.mkDerivation {
    name = "tiledb";
    version = "1.6.2";

  src = fetchgit {
    url = "https://github.com/TileDB-Inc/TileDB";
    rev = "0eb1eba7a9ff0ada0165bd61c84239bec9cf0f00";
    sha256 = "sha256:15i8rc2w3pnjz6chraf8nznk8p4mpgi4nx88v9jrg2s3hh092drb";
  };

  preInstall = ''
    make doc
    make check
  '';

  makeTarget = "tiledb";

  installTargets = "install-tiledb";

  nativeBuildInputs = [clang-tools cmake doxygen  gtest];

  buildInputs = [ catch2 zlib lz4 bzip2 zstd spdlog_0 tbb openssl boost libpqxx python ];

  # emulate the process of pulling catch down
  postPatch = ''
    mkdir -p build/externals/src/ep_catch
    ln -sf ${catch2}/include/catch2 build/externals/src/ep_catch/single_include
  '';

  meta = with lib; {
    description = "TileDB allows you to manage the massive dense and sparse multi-dimensional array data";
    homepage = https://github.com/TileDB-Inc/TileDB;
    license = licenses.mit;
    maintainers = with maintainers; [ rakesh4g ];
  };
}
