let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
  nixpkgs_download = fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    #rev = "dcf40f7c24eec1160e6433b6644d3e2dd268e417";
    #sha256 = "0ajwr7n72njkj87asr29bs94pyg61ix6fx7a239n9ik6bisg639y";
    rev = "444b26e3b5df0d3207b08c0e0102d27d07403d15";
    sha256 = "0jx27y8if2qs74p8km3lkpmgs4q816kr9h5fq8z0gr700j6bgz4g";
    #rev = "84067b7ef1f35a405f1201e8372f62e876e22ab6"; #"7f35ed9df40f12a79a242e6ea79b8a472cf74d42";
    #/nix/store/003jhgnff2dwnz4j23wsqhzx9mdbxsha256 = "1wr6dzy99rfx8s399zjjjcffppsbarxl2960wgb0xjzr7v65ffff"; 
 };
in
  import nixpkgs_download {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  }
