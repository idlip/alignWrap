{
  description = "A basic flake for using R";
  # inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/f99e5f03cc0aa231ab5950a15ed02afec45ed51a";

  outputs = {self, nixpkgs } :
    let
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pkgs = import nixpkgs {
        inherit system;
      };

    in {
      devShell.${system} = pkgs.mkShell {

        nativeBuildInputs = [ pkgs.bashInteractive ];
        buildInputs = builtins.attrValues {
          inherit (pkgs)
            R
            bwa bowtie2 minimap2 star
            ;
          inherit (pkgs.rPackages)
            lintr
            languageserver
            tidyverse # includes suite of 9 packages
            Biostrings
            BiocManager
            devtools
            # limma
            # DESeq2
            # GEOquery
            # umap
            # maptools
            # car
            # # wateRmelon
          # shiny

          # add more packages (https://search.nixos.org)
          # from CRAN or Bioconductor
            ;
        };

        # Example for rstudio
        # pkgs.rstudioWrapper.override {
        #   packages = with pkgs.rPackages; [
        #   dplyr
        #     ggplot2
        #     reshape2;
        # ];
        # }
      };
    };
}
