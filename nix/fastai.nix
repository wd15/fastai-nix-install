{ nixpkgs, pypkgs }:
let
  pkgs = nixpkgs.pkgs;
  spacy = import ./spacy.nix { inherit pypkgs; };
  nvidia-ml-py3 = import ./nvidia-ml-py3.nix { inherit pypkgs; };
  # pypi2nix = import ./requirements.nix { inherit pkgs; }; 
  fastprogress = import ./fastprogress.nix { inherit pypkgs; };
  pandas = pypkgs.pandas.overridePythonAttrs (oldAttrs: {
    doCheck=false;
  });
  stdenv48 = nixpkgs.overrideCC nixpkgs.stdenv nixpkgs.pkgs.gcc48;
  #buildPythonPackage48 = nixpkgs.overrideCC pypkgs.buildPythonPackage nixpkgs.pkgs.gcc48;
  cudatoolkit = pkgs.cudatoolkit_9_0.override { gcc6 = pkgs.gcc48; };
  pytorch = pypkgs.pytorch.override  {
    cudatoolkit = cudatoolkit;
    cudnn = pkgs.cudnn_cudatoolkit_9_0;
    cudaSupport = true;
    stdenv = stdenv48;
    #buildPythonPackage = buildPythonPackage48;
  };
  pytorch_ = pytorch.overridePythonAttrs (oldAttrs: {
    doCheck=false;
  });
in
  #buildPythonPackage48 rec {
  pypkgs.buildPythonPackage rec {
    pname = "fastai";
    version = "1.0.49";
    src = pypkgs.fetchPypi {
      inherit pname version;
      sha256 = "04rld53dbmsy5706ign9z8f75d8rgwv3lccsf32wm7sadgl4i92c";
    };
    doCheck = false;
    propagatedBuildInputs = [
      pypkgs.bottleneck
      pandas
      # pypkgs.pytorch
      pytorch_
      pypkgs.matplotlib
      pypkgs.torchvision
      spacy 
      pypkgs.typing
      nvidia-ml-py3
      pypkgs.dataclasses
      pypkgs.pytestrunner
      # pypi2nix.packages."fastprogress"
      fastprogress
    ];
    catchConflicts = false;
  }
