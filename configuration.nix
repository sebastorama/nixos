{ config, pkgs, ... }:

{
  networking.hostName = "zduo";   # Define your hostname.

  imports =
    [
      ./hardware-configuration.nix
    ];

  zramSwap.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_8;
  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
    "vfio-pci"
    "i915.force_probe=!7d55"
    "xe.force_probe=7d55"
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      qemu.swtpm.enable = true;
      onBoot = "start"; # remove need for 'sudo virsh net-start default'
    };
    docker.enable = true;
    docker.package = pkgs.docker_26;
    podman.enable = true;
  };

  programs.virt-manager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  networking.wireless.extraConfig = ''
   bgscan="simple:30:-70:3600"
  '';

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  services.flatpak.enable = true;
  services.power-profiles-daemon.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "sebastorama";
  services.desktopManager.plasma6.enable = true;

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  services.xserver = {
    xkb.variant = "mac";
    xkb.layout = "us";
  };

  services.printing = {
    enable = true;
    drivers = [
      pkgs.epson-escpr
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.logitech.wireless.enable = true;

  security.rtkit.enable = true;
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;  # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
  security.tpm2.tctiEnvironment.enable = true;  # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sebastorama = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "sebastorama";
    extraGroups = [ "video" "networkmanager" "wheel" "tss" "docker" "libvirtd" "qemu-libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kdeconnect-kde
    ];
  };

  fileSystems."/home/sebastorama/.cache/kwin" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=10M" "mode=777" ];
  };

  fileSystems."/home/sebastorama/.cache/plasmashell" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=10M" "mode=777" ];
  };

  fileSystems."/home/sebastorama/.cache/mesa_shader_cache" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=10M" "mode=777" ];
  };

  fileSystems."/home/sebastorama/.cache/kscreen_osd_service" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=10M" "mode=777" ];
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
     pkgs.distrobox
     pkgs.kitty
     pkgs.localsend
     pkgs.lsof
     pkgs.mtr
     pkgs.pciutils
     pkgs.solaar
     pkgs.vim
     pkgs.virglrenderer
     pkgs.virt-viewer
     pkgs.virtiofsd
     pkgs.wget
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "iHD";
  };

  networking.firewall.allowedTCPPorts = [
    53317 # localsend
  ];

  networking.firewall.allowedUDPPorts = [
    53317 # localsend
  ];

  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; } # KDE Connect
  ];

  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; } # KDE Connect
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
