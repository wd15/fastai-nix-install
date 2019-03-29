{ pypkgs }:
pypkgs.buildPythonPackage rec {
  pname = "fastprogress";
  version = "0.1.20";
  src = pypkgs.fetchPypi {
    inherit pname version;
    sha256 = "09114dd8a242005d127d9d8d61cfb39b989e24d3b9b892ff3bf6229a7286d9a9";
  };
  doCheck=false;
  buildInputs = [
    pypkgs.pytestrunner
  ];
  catchConflicts = false;
}
