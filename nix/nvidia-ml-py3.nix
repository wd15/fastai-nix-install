{ pypkgs }:
pypkgs.buildPythonPackage rec {
  pname = "nvidia-ml-py3";
  version = "7.352.0";
  src = pypkgs.fetchPypi {
    inherit pname version;
    sha256 = "0xqjypqj0cv7aszklyaad7x3fsqs0q0k3iwq7bk3zmz9ks8h43rr";
  };
  doCheck=false;
  buildInputs = [
  ];
  catchConflicts = false;
}
