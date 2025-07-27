{  config,
  pkgs,
  libs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Liga SFMono Nerd Font";
      #size = if pkgs.stdenv.isDarwin then 18 else 12;

    };
    settings = {

      window_border_width = "0.0";
      window_padding_width = 1;



      confirm_os_window_close = 0;
      dynamic_background_opacity  = true;
      ebable_audio_bell = false;
      background_opacity = "0.5";
      background_blur = 5;
      cursor_trial = 3;
     

      cursor_shape = "beam";
      cursor_blink_interval = 0;


      # Kitty window border colors
      active_border_color = "#B4BEFE";
      inactive_border_color = "#6C7086";
      bell_border_color = "#F9E2AF";

    };
  };
}
