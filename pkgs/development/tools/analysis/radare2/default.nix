{ lib
, stdenv
, fetchFromGitHub
, buildPackages
, pkg-config
, libusb-compat-0_1
, readline
, libewf
, perl
, zlib
, openssl
, libuv
, file
, libzip
, xxHash
, gtk2
, vte
, gtkdialog
, python3
, ruby
, lua
, capstone
, fetchpatch
, useX11 ? false
, rubyBindings ? false
, pythonBindings ? false
, luaBindings ? false
}:

stdenv.mkDerivation rec {
  pname = "radare2";
  version = "5.2.1";

  src = fetchFromGitHub {
    owner = "radare";
    repo = "radare2";
    rev = version;
    sha256 = "0n3k190qjhdlj10fjqijx6ismz0g7fk28i83j0480cxdqgmmlbxc";
  };

  patches = [
    # fix for CVE-2021-32613
    (fetchpatch {
      url = "https://github.com/radareorg/radare2/commit/5e16e2d1c9fe245e4c17005d779fde91ec0b9c05.patch";
      sha256 = "sha256-zCFNn968buLuSqfUT5E+72qz0l1tA3fEUQIxJl2nd3I=";
    })
    (fetchpatch {
      name = "CVE-2021-32613.patch";
      url = "https://github.com/radareorg/radare2/commit/049de62730f4954ef9a642f2eeebbca30a8eccdc.patch";
      sha256 = "sha256-s8SWGuSQ6fxDCybtjO2ZW8w7H6mr+AuzVLL6dw+XKDw=";
    })
  ];

  postInstall = ''
    install -D -m755 $src/binr/r2pm/r2pm $out/bin/r2pm
  '';

  WITHOUT_PULL = "1";
  makeFlags = [
    "GITTAP=${version}"
    "RANLIB=${stdenv.cc.bintools.bintools}/bin/${stdenv.cc.bintools.targetPrefix}ranlib"
  ];
  configureFlags = [
    "--with-sysmagic"
    "--with-syszip"
    "--with-sysxxhash"
    "--with-syscapstone"
    "--with-openssl"
  ];

  enableParallelBuilding = true;
  depsBuildBuild = [ buildPackages.stdenv.cc ];

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    capstone
    file
    readline
    libusb-compat-0_1
    libewf
    perl
    zlib
    openssl
    libuv
  ] ++ lib.optional useX11 [ gtkdialog vte gtk2 ]
    ++ lib.optional rubyBindings [ ruby ]
    ++ lib.optional pythonBindings [ python3 ]
    ++ lib.optional luaBindings [ lua ];

  propagatedBuildInputs = [
    # radare2 exposes r_lib which depends on these libraries
    file # for its list of magic numbers (`libmagic`)
    libzip
    xxHash
  ];

  meta = {
    description = "unix-like reverse engineering framework and commandline tools";
    homepage = "http://radare.org/";
    license = lib.licenses.gpl2Plus;
    maintainers = with lib.maintainers; [ raskin makefu mic92 ];
    platforms = with lib.platforms; linux;
    inherit version;
  };
}
