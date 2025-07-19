/// @desc Out-of-bounds – ball itself  (2025-06-22 16:20 CDT)

/* ── 0.  Ignore if ball attached or play ended ── */
if (objQB.playEnded || other.attached_to != noone) exit;

/* ── 1.  FEET-ONLY analog for ball:
         Use the bottom 5 px of the ball sprite.            ── */
var foot_top    = other.bbox_bottom - 5;
var foot_bottom = other.bbox_bottom;

if (foot_bottom < bbox_top)  exit;
if (foot_top    > bbox_bottom) exit;

/* ── 2.  Whistle & freeze play ── */
audio_play_sound(sndWhistle, 1, false);

var new_los_x = other.x - 40;

with (objQB)
{
    playEnded      = true;
    throw_cooldown = 60;
    objScrimmageMarker.x = new_los_x;
    can_throw      = false;
}

global.play_active     = false;
global.player_has_ball = noone;

with (other)
{
    play_active = false;
    attached_to = noone;
    speed       = 0;
    visible     = true;
}
