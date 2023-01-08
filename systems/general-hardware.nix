{pkgs, conifg, lib, ...}:

{
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    sound.enable = true;
 #   hardware.pulseaudio.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    services.printing.enable = true;

    hardware.bluetooth = {
        enable = true;
        settings = {
            General = {
                Enable = "Source,Sink,Media,Socket";
            };
        };
    };
}
