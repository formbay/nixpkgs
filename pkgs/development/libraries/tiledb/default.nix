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
    version = "1.5.1";

  src = fetchgit {
    url = "https://github.com/TileDB-Inc/TileDB";
    rev = "7236bb29f2aa1ac4de489f0791e9265cb257184d";
    sha256 = "sha256:0ky0dcv1w1jn1cjn3819aq9xyd2wg80aagf2flxmd916flgr9zjl";
  };

  preInstall = ''
    make doc
    make check
  '';

  makeTarget = "tiledb";

  nativeBuildInputs = [clang-tools cmake doxygen  gtest];

  buildInputs = [ catch2 zlib lz4 bzip2 zstd spdlog_0 tbb openssl boost libpqxx python ];

  # emulate the process of pulling catch down
  postPatch = ''
    mkdir -p build/externals/src/ep_catch
    ln -sf ${catch2}/include/catch2 build/externals/src/ep_catch/single_include
  '';

#  cmakeFlags = [
#  "-DCATCH_INCLUDE_DIR=${catch2}"
#  "-DTILEDB_SUPERBUILD=OFF"
#  "-DINCLUDE_DIR=${clang-tools}/bin"
#  ];

  meta = with lib; {
    description = "TileDB allows you to manage the massive dense and sparse multi-dimensional array data";
    homepage = https://github.com/TileDB-Inc/TileDB;
    license = licenses.mit;
    maintainers = with maintainers; [ rakesh4g ];
  };
}
