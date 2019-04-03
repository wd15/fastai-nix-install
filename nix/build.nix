{ nixpkgs }:
let
  pkgs = nixpkgs.pkgs;
  pypkgs = nixpkgs.python36Packages;
  fastai = import ./fastai.nix { inherit nixpkgs; inherit pypkgs; };
in
  [
    pkgs.python36
    pypkgs.pillow
    pypkgs.numpy
    pypkgs.toolz
    pypkgs.matplotlib
    pypkgs.pytest
    pypkgs.pip
    pypkgs.ipywidgets
    pypkgs.jupyter
    pypkgs.wheel
    fastai
  ]
