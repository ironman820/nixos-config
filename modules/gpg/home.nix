{ config, agenix, ... }:

{
    home = {
        age.secrets."personal.gpg.master" = {
            file = ../../secrets/home/global/gpg/master.age;
            path = "~/personal-gpg/11B0F08E0A4D904B.master.key";
            group = "users";
            mode = "0400";
        }
    }
}