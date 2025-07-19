/// @desc Alarm[1] – full field reset

/* 1 ▸   Move line-of-scrimmage ONLY if the last pass was caught */
if (pass_was_caught)
{
    objScrimmageMarker.x = x;          // new LOS
    obj1stDMarker.x      = x + 330;    // first-down marker
}

/* 2 ▸   Football on ground at LOS, visible & free */
x = objScrimmageMarker.x;
y = 616;
speed = direction = 0;
attached_to = noone;
visible = true;
visual_z = visual_arc_time = visual_arc_total = visual_arc_peak = 0;

global.play_active     = false;
global.player_has_ball = noone;
pass_was_caught        = false;

/* 3 ▸   QB 50 px behind ball, cannot move until hike */
with (objQB)
{
    x = objScrimmageMarker.x - 75;   // 50-px offset
    y = 570;                         // adjust if needed

    /* freeze state */
    hiked       = false;
    ballHiked   = false;
    playEnded   = false;
    can_throw   = true;          // will be allowed AFTER hike
    throw_cooldown = 0;

    attached_to = id;            // QB “owns” ball pre-snap
    sprite_index = Player_qb_pre_snap;

    key_held = -1; key_hold_timer = 0; selected_wr = noone;
}

/* 4 ▸   Reset every WR (stop celebrations, face LOS) */
with (objWRParent)
{
    celebrating  = false; celebration_timer = 0;
    caught = hasBall = false;

    returning      = true;
    path_started   = false;
    route_finished = false;
    path_pending   = true;

    /* face left toward defense */
    image_xscale = -1;
}

/* 5 ▸   Stop looping crowd SFX & clear global TD flag */
audio_stop_sound(sndCrowd);
global.touchdown_scored = false;

/* 6 ▸   Done */
alarm[1] = -1;
