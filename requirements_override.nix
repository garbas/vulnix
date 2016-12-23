{ pkgs, python }:

self: super: {

  "flake8" = python.overrideDerivation super."flake8" (old: {
    buildInputs = old.buildInputs ++ [ self."pytest-runner" ];
  });

  "mccabe" = python.overrideDerivation super."mccabe" (old: {
    buildInputs = old.buildInputs ++ [ self."pytest-runner" ];
  });

  "pytest-runner" = python.overrideDerivation super."pytest-runner" (old: {
    buildInputs = old.buildInputs ++ [ self."setuptools-scm" ];
  });

  "PyYAML" = python.overrideDerivation super."PyYAML" (old: {
    propagatedNativeBuildInputs = old.propagatedBuildInputs ++ [ pkgs.libyaml ];
  });

  "BTrees" = python.overrideDerivation super."BTrees" (old: {
    propagatedNativeBuildInputs =
      builtins.filter
        (x: (builtins.parseDrvName x.name).name != "${python.__old.python.libPrefix}-ZODB")
        old.propagatedNativeBuildInputs;
    #
  });

}
