let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
  nixpkgs_download = fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "444b26e3b5df0d3207b08c0e0102d27d07403d15";
    sha256 = "0jx27y8if2qs74p8km3lkpmgs4q816kr9h5fq8z0gr700j6bgz4g";
 };
in
  import nixpkgs_download {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  }
