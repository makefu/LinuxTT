{ pkgs, lib, config, ...}:
let
  user = config.ttlinux.user;
in

{ # works for kde
  services.xserver = {
    #desktopManager.plasma6.enable = true;
    #desktopManager.plasma5.enable = lib.mkForce false;
  };

  system.activationScripts.installerDesktop = let

    # Comes from documentation.nix when xserver and nixos.enable are true.
    manualDesktopFile = "/run/current-system/sw/share/applications/nixos-manual.desktop";

    homeDir = "/home/${user}/";
    desktopDir = homeDir + "Desktop/";

  in lib.mkForce ''
    mkdir -p ${desktopDir}
    chown ${user} ${homeDir} ${desktopDir}

    ln -sfT ${manualDesktopFile} ${desktopDir + "nixos-manual.desktop"}
    ln -sfT ${pkgs.gparted}/share/applications/gparted.desktop ${desktopDir + "gparted.desktop"}
    ln -sfT ${pkgs.konsole}/share/applications/org.kde.konsole.desktop ${desktopDir + "org.kde.konsole.desktop"}
    ln -sfT ${pkgs.calamares-nixos}/share/applications/io.calamares.calamares.desktop ${desktopDir + "io.calamares.calamares.desktop"}
  '';

  environment.systemPackages = with pkgs;[
    libsForQt5.kpmcore
    calamares-nixos
    calamares-nixos-extensions
    glibcLocales
  ];

  i18n.supportedLocales = [ "all" ];
}
