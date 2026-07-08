{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;

    extensions = [
      # ghostery
      { id = "mlomiejdfkolichcflejclcbmpeaniij"; }

      # proton pass
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; }

      # tapermonkey
      { id = "dhdgffkkebhmkfjojejmpbldmpobfkfo"; }

      # zen hordes
      { id = "mfmegmfbgapnopkjfocndlkbdapaogam"; }

      # MHOA
      { id = "jolghobcgphmgaiachbipnpiimmgknno"; }
    ];
  };
}
