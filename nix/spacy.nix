{ pypkgs }:
let
  ftfy = pypkgs.ftfy.overridePythonAttrs (oldAttrs: {checkPhase='''';});
  remove_ftfy = (builtins.filter (x: "ftfy" != x.pname ) pypkgs.spacy.propagatedBuildInputs);
in
  pypkgs.spacy.overridePythonAttrs (oldAttrs: {
    propagatedBuildInputs = remove_ftfy ++ [ ftfy ];
  })
