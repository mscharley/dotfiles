{ pkgs, rev }:
pkgs.stdenv.mkDerivation {
  pname = "git-extensions";
  version = rev;

  dontUnpack = true;

  nativeBuildInputs = [ pkgs.bash ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 ${../../../configs/xdg/bin/git-cleanup} $out/bin/git-cleanup
    install -m755 ${../../../configs/xdg/bin/git-cleanup-remotes} $out/bin/git-cleanup-remotes
    install -m755 ${../../../configs/xdg/bin/git-main} $out/bin/git-main
    patchShebangs $out/bin
    runHook postInstall
  '';
}
