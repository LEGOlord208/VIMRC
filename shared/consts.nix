rec {
  email = "me@krake.one";
  name  = "jD91mZM2";

  user     = "user";
  home     = "/home/${user}";
  dotfiles = "${home}/dotfiles";
  sshKeys  = [ "${dotfiles}/keys/computer.pub" "${dotfiles}/keys/laptop.pub" ];

  secret = import ./secret.nix;

  syncthingDevices = {
    laptop = {
      id = "ILTIRMY-JT4SGSQ-AWETWCV-SLQYHE6-CY2YGAS-P3EGWY6-LSP7H4Z-F7ZQIAN";
      introducer = true;
    };
    computer = {
      id = "PPZ6RHN-2WYP3HI-OMQKLHY-4LZW6RK-L6CFPK6-G4QTVPV-SUIZH6S-F5E72QB";
      introducer = true;
    };
    droplet = {
        id = "4JBUWER-ECEJGT7-XH6NFJB-F4WBHP2-CPREUK6-ETHPHHU-LXGPP3O-IAYLNAI";
        addresses = [ "tcp://krake.one:22000" ];
    };
    phone.id  = "O7H6BPC-PKQPTT4-T4SEA7K-VI7HJ4K-J7ZJO5K-NWLNAK5-RBVCSBU-EXDHSA3";
    rpi.id    = "KFJ55KX-GEL7PFY-4KBSZG4-WEIUGTV-ICE52PD-PTFUZDV-5PSUOKH-CMNNPQ4";
    school.id = "6YYJM7K-ZP3CXHB-P4KU6CF-PVF4RG4-MFGBGXG-CUGZ26X-Z42TS6Q-BVHWKQP";
  };
}
