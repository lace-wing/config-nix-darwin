{
  self,
  pkgs,
	lib,
  config,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware/tp-t14.nix
  ];

  services.openssh.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Canada/Pacific";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = lib.mkDefault {
    font = "Lat2-Terminus16";
    keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver = {
  #   enable = false;
  #   videoDrivers = [ "intel" ];
  # };

  # Enable polkit
  security.polkit.enable = true;

  # Enable RealtimeKit
  security.rtkit.enable = true;

  # pam config
  security.pam.services = {
    swaylock = { };
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.gnome = {
    gnome-keyring.enable = true;
  };

  # services.devmon.enable = true;
  # services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090; # (If the vfs0090 Driver does not work, use the following driver)
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix; # (On my device it only worked with this driver)


  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];

  environment.systemPackages = with pkgs; [
    fprintd
    file
    zip
    unzip
    tree
    gnumake
    cmake
    vim
    neovim
    wget
    git
  ];

  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "tp-t14";
}
