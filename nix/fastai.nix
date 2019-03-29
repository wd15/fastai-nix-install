{ nixpkgs, pypkgs }:
let
  pkgs = nixpkgs.pkgs;
  spacy = import ./spacy.nix { inherit pypkgs; };
  nvidia-ml-py3 = import ./nvidia-ml-py3.nix { inherit pypkgs; };
  # pypi2nix = import ./requirements.nix { inherit pkgs; }; 
  fastprogress = import ./fastprogress.nix { inherit pypkgs; };
in
  pypkgs.buildPythonPackage rec {
    pname = "fastai";
    version = "1.0.49";
    src = pypkgs.fetchPypi {
      inherit pname version;
      sha256 = "04rld53dbmsy5706ign9z8f75d8rgwv3lccsf32wm7sadgl4i92c";
    };
    doCheck=false;
    propagatedBuildInputs = [
      pypkgs.bottleneck
      pypkgs.pandas
      pypkgs.pytorch
      pypkgs.matplotlib
      pypkgs.torchvision
      pypkgs.spacy 
      pypkgs.typing
      nvidia-ml-py3
      pypkgs.dataclasses
      pypkgs.pytestrunner
      # pypi2nix.packages."fastprogress"
      fastprogress
    ];
    catchConflicts = false;
  }
