{
    pkgs ? (import <nixpkgs> {}),
}:

with pkgs;

stdenv.mkDerivation {
  name = "LaTeX";
  buildInputs = [ (texlive.combine {
                    inherit (texlive)
                      scheme-full

                      # Add other LaTeX libraries (packages) here as needed, e.g:
                      # stmaryrd amsmath pgf

                      # build tools
                      latexmk
                      ;
                  })
                  glibcLocales
                  imagemagick
                  plantuml
                  docker-compose
                ];

  meta = with lib; {
    description = "LaTeX document";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
