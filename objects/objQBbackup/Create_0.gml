/// @desc QB Initialize

// states
hiked            = false;
ballHiked        = false;
playEnded        = false;
can_throw        = true;
throw_cooldown   = 0;
selected_wr      = noone;

// throw mechanics
throw_power_base   = 6;
max_throw_distance = 2200;
max_charge         = 30;
key_hold_timer     = 0;
key_held           = -1;

// scrimmage
line_of_scrimmage_start = objScrimmageMarker.x;
kickoff_spot_x         = 200;

// QB starts with ball in hand
attached_to = id;

// default sprite + sound
sprite_index = sprQbPresnap_gry;
image_xscale = 1;
depth        = -100;
audio_play_sound(sndHut, 5, true);
/* touchdown‐run variables (default = not celebrating) */
celebrate_buffer   = 0;
celebrate_target_x = x;
