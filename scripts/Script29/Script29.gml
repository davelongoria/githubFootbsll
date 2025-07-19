// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//function Script29(){
//--------------------------------------------------------------
// 5.  (preview / palette update if you use one)  --------------
//--------------------------------------------------------------
// scr_palette_init( teams[home_index] );
// scr_palette_init( teams[away_index] );

/*
/// objTeamController – Step
//--------------------------------------------------------------
var team_ct = array_length(teams);

// helper wrap
function wrap_up(i){ return (i - 1 + team_ct) mod team_ct; }
function wrap_dn(i){ return (i + 1)        mod team_ct; }

//--------------------------------------------------------------
// 1. Game-pad / keyboard input  (P1 = pad 0 / KB) --------------

// --- left-stick axes (pad 0) ---
var ax  = gamepad_axis_value(0, gp_axislh);
var ay  = gamepad_axis_value(0, gp_axislv);

if (is_undefined(prev_ax)) { prev_ax = ax; prev_ay = ay; }

var tap_thr = 0.85;          // how hard the flick must be
var p1_left  =  ax < -tap_thr && prev_ax > -tap_thr;
var p1_right =  ax >  tap_thr && prev_ax <  tap_thr;
var p1_up    =  ay < -tap_thr && prev_ay > -tap_thr;
var p1_down  =  ay >  tap_thr && prev_ay <  tap_thr;

prev_ax = ax; prev_ay = ay;

// add keyboard mirrors (optional)
p1_left  |= keyboard_check_pressed(ord("A"));
p1_right |= keyboard_check_pressed(ord("D"));
p1_up    |= keyboard_check_pressed(vk_up);
p1_down  |= keyboard_check_pressed(vk_down);

//--------------------------------------------------------------
// 2. Swap sides ------------------------------------------------
if (p1_left || p1_right)
{
    // swap sides
    p1.side ^= 1;
    cpu_or_p2.side ^= 1;

    // move markers
    p1.x        = xs[p1.side];
    cpu_or_p2.x = xs[cpu_or_p2.side];

    // swap indices so HOME remains left column
    var t       = home_index;
    home_index  = away_index;
    away_index  = t;

    if (have_sndSelect) audio_play_sound(sndSelect, 0, false);
}

//--------------------------------------------------------------
// 3. Scroll teams (P1 controls whichever side he occupies) -----
if (p1.side == 0)    // P1 on HOME
{
    if (p1_up)   home_index = wrap_up(home_index);
    if (p1_down) home_index = wrap_dn(home_index);
}
else                 // P1 on AWAY
{
    if (p1_up)   away_index = wrap_up(away_index);
    if (p1_down) away_index = wrap_dn(away_index);
}
/*
// keep indices distinct
if (home_index == away_index)
{
    away_index = wrap_dn(away_index);
}
*/
//--------------------------------------------------------------
// 4. Pad-1 joins / times-out ----------------------------------

/*
var p2_start = gamepad_button_check_pressed(1, gp_start);

if (!p2_is_human && p2_start)
{
    // CPU becomes Player-2
    p2_is_human             = true;
    cpu_or_p2.sprite_index   = sprP2;
    cpu_or_p2.is_cpu         = false;
    p2_idle_ctr              = 0;
    if (have_sndPress) audio_play_sound(sndPressed,0,false);
}
else if (p2_is_human)
{
    // monitor any pad-1 activity
    var any_btn =
        p2_start                                         ||
        abs(gamepad_axis_value(1,gp_axislv)) > 0.2       ||
        abs(gamepad_axis_value(1,gp_axislh)) > 0.2;

    if (any_btn) p2_idle_ctr = 0; else p2_idle_ctr++;

    // revert to CPU
    if (p2_idle_ctr > cpu_idle_steps)
    {
        p2_is_human             = false;
        cpu_or_p2.sprite_index   = sprCPU;
        cpu_or_p2.is_cpu         = true;
        p2_idle_ctr              = 0;
    }

    // player-2 scrolls only its own column
    var ax1  = gamepad_axis_value(1, gp_axislh);
    var ay1  = gamepad_axis_value(1, gp_axislv);
    if (is_undefined(prev_ax1)){ prev_ax1 = ax1; prev_ay1 = ay1; }

    var p2_up   = ay1 < -tap_thr && prev_ay1 > -tap_thr;
    var p2_down = ay1 >  tap_thr && prev_ay1 <  tap_thr;

    if (p2_up)   away_index = wrap_up(away_index);
    if (p2_down) away_index = wrap_dn(away_index);
    if (away_index == home_index) away_index = wrap_dn(away_index);

    prev_ax1 = ax1; prev_ay1 = ay1;
}

//--------------------------------------------------------------
// 5. Update marker palettes / helmets etc (if you have that) ---
/*
scr_palette_init( teams[home_index] );   // for HOME preview
scr_palette_init( teams[away_index] );   // for AWAY preview
*/

//}