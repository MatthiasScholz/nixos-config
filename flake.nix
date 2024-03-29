{
  description = "MacOS basics";

  inputs = {
      # TODO how to make OS independent?
      # stable
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
      home-manager.url = "github:nix-community/home-manager/release-22.11";
      # most recent
      #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      #home-manager.url = "github:nix-community/home-manager";
      
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
      # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...

      ## Emacs
      # FIXME NOT WORKING emacs-overlay.url = "github:nix-community/emacs-overlay";
      # FIXME NOT WORKING emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  # add the inputs declared above to the argument attribute set
  outputs = { self, nixpkgs, home-manager, darwin }: {

    darwinConfigurations."MacPro" = darwin.lib.darwinSystem {
    # you can have multiple darwinConfigurations per flake, one per hostname
      system = "x86_64-darwin";
      # FIXME make host dependent
      #modules = [ home-manager.darwinModules.home-manager ./hosts/MacPro/default.nix]; # will be important later
      modules = [ home-manager.darwinModules.home-manager ./hosts/MacTW/default.nix]; # will be important later
    };




  };
}
