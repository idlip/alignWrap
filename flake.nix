{
  description = "A basic flake for using R";
  # inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/9df3e30ce24fd28c7b3e2de0d986769db5d6225d";

  outputs = {self, nixpkgs } :
    let
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pkgs = import nixpkgs {
        inherit system;
      };

      rpkgs = with pkgs.rPackages; [
        lintr
        languageserver
        tidyverse # includes 9 packages that are down below
        Biostrings
        BiocManager
        # ggmsa
        devtools

        # add more packages (https://search.nixos.org)
        # from CRAN or Bioconductor
      ];

    in {
      devShell.${system} = pkgs.mkShell {

        buildInputs = with pkgs; [
          bwa bowtie2 star minimap2

          (rWrapper.override {
            packages = [
              rpkgs
            ];
          })

            (rstudioWrapper.override {
              packages = [
                rpkgs
              ];
            })
        ];
      };
    };
}
