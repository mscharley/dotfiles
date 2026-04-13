{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "git-extensions";

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ bash ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    export coreutils=${pkgs.coreutils}
    export git=${pkgs.git}
    export sed=${pkgs.gnused}
    export grep=${pkgs.gnugrep}
    install -m755 ${./git-cleanup} $out/bin/git-cleanup
    substituteAllInPlace $out/bin/git-cleanup
    install -m755 ${./git-cleanup-remotes} $out/bin/git-cleanup-remotes
    substituteAllInPlace $out/bin/git-cleanup-remotes
    install -m755 ${./git-main} $out/bin/git-main
    substituteAllInPlace $out/bin/git-main
    patchShebangs $out/bin
    runHook postInstall
  '';
}
