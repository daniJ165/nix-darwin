  # home.nix
# home-manager switch 

{ config, pkgs, lib, ... }:


{
  imports = [
    ./modules/kitty.nix
    ./modules/aerospace.nix


    ];

   
  home.username = "danielle";
  home.homeDirectory = "/Users/danielle";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.shellAliases = {
    manix = "man 5 configuration.nix";
    rebuild = "sudo darwin-rebuild switch --flake ~/.config/nix-darwin#macbook-air";
    home = "nvim ~/.config/nix-darwin/home.nix";
    flake = "nvim ~/.config/nix-darwin/flake.nix";
    kitty = "nvim ~/.config/nix-darwin/modules/kitty.nix";
    space = "nvim ~/.config/nix-darwin/modules/aerospace.nix";
    };

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = with pkgs; [
    tmux
    fzf
    fastfetch
    ranger
    btop
    cmatrix
    #jankyborders
   # aerospace
    	


  ];



  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".zshrc".source = ~/dotfiles/zshrc/.zshrc;
    # ".config/wezterm".source = ~/dotfiles/wezterm;
    # ".config/skhd".source = ~/dotfiles/skhd;
    # ".config/starship".source = ~/dotfiles/starship;
    # ".config/zellij".source = ~/dotfiles/zellij;
    # ".config/nvim".source = ~/dotfiles/nvim;
    # ".config/nix".source = ~/dotfiles/nix;
    # ".config/nix-darwin".source = ~/dotfiles/nix-darwin;
    # ".config/tmux".source = ~/dotfiles/tmux;
    # ".config/ghostty".source = ~/dotfiles/ghostty;
     #".config/aerospace".source = ~/.c.aerospace.toml;
    # ".config/sketchybar".source = ~/dotfiles/sketchybar;
    # ".config/nushell".source = ~/dotfiles/nushell;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    #"/run/current-system/sw/bin"
    #  "$HOME/.nix-profile/bin"
  ];

  programs.home-manager.enable = true;
  #services.tailscale.enable = true;

  programs.zsh = {
    enable = true;
    # initContent = ''
      # Add any additional configurations here
     #  export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
     # if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    #    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
   #   fi
  #  '';
  };
}
