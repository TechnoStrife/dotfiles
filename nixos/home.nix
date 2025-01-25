{ config, pkgs, username, stateVersion, ... }:

let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = stateVersion; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    git-credential-manager
    python314
    rustup
    lazygit
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/nvim".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tech/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {

  };
  home.sessionPath = [ "~/.cargo/bin" ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.go = {
    enable = true;
    goPath = ".local/go";
    # goBin = ".local/go/bin";
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      . "/etc/profiles/per-user/tech/etc/profile.d/hm-session-vars.sh"
    '';
  };

  programs.git = {
    enable = true;
    userName  = "technostrife";
    userEmail = "technostrife@gmail.com";
    extraConfig = {
      init = { defaultBranch = "main"; };
      credential = {
        credentialStore = "secretservice";
        helper = "manager";
        "https://github.com".username = "TechnoStrife";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.btop.enable = true; # replacement of htop/nmon
}
