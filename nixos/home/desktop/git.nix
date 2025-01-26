{ config, pkgs, inputs, ... }:

{
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
}
