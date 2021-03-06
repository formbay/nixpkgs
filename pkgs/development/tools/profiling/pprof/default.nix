# This file was originally generated by https://github.com/kamilchm/go2nix v1.2.1
{ lib, buildGoPackage, fetchgit }:

buildGoPackage rec {
  pname = "pprof-unstable";
  version = "2018-08-15";
  rev = "781f11b1fcf71fae9d185e7189b5e686f575075a";

  goPackagePath = "github.com/google/pprof";

  src = fetchgit {
    inherit rev;
    url = "git://github.com/google/pprof";
    sha256 = "1nvzwcj6h4q0lsjlri3bym4axgv848w3xz57iz5p0wz9lcd5jsmf";
  };

  goDeps = ./deps.nix;

  meta = with lib; {
    description = "A tool for visualization and analysis of profiling data";
    homepage = "https://github.com/google/pprof";
    license = licenses.asl20;
    longDescription = ''
      pprof reads a collection of profiling samples in profile.proto format and generates reports to visualize and help analyze the data. It can generate both text and graphical reports (through the use of the dot visualization package).

      profile.proto is a protocol buffer that describes a set of callstacks and symbolization information. A common usage is to represent a set of sampled callstacks from statistical profiling. The format is described on the proto/profile.proto file. For details on protocol buffers, see https://developers.google.com/protocol-buffers

      Profiles can be read from a local file, or over http. Multiple profiles of the same type can be aggregated or compared.

      If the profile samples contain machine addresses, pprof can symbolize them through the use of the native binutils tools (addr2line and nm).

      This is not an official Google product.
    '';
  };
}
