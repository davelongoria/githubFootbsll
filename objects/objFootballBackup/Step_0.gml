/// @desc objFootball – Step  (2025-06-22 17:50 CDT)

/* 0 ── PRE-SNAP: ball on LOS */
if (!global.play_active && attached_to == noone)
{
    x = objScrimmageMarker.x-75;
    y = 616;
    speed = 0; direction = 0;
    visual_z = 0; visual_arc_time = 0;
    visual_arc_total = 0; visual_arc_peak = 0;
    visible = true;

    pass_was_caught = false;   // reset flag for next play
    exit;
}

/* 1 ── ATTACHED: follow carrier, hidden */
if (attached_to != noone)
{
    if (instance_exists(attached_to))
    {
        var owner = attached_to;
        x = owner.x + 32;
        y = owner.y + 22;
        visible = false;
        speed = 0; direction = 0;
        visual_z = 0; visual_arc_time = 0;
        visual_arc_total = 0;
        exit;
    }
    else attached_to = noone;
}

/* 2 ── IN-AIR: thrown state */
if (global.play_active && attached_to == noone)
{
    /* 2-A  flight physics & arc */
    visible = true;
    x += lengthdir_x(speed, direction);
    y += lengthdir_y(speed, direction);

    if (visual_arc_time < visual_arc_total)
    {
        var pct = visual_arc_time / visual_arc_total;
        visual_z = -sin(pct * pi) * visual_arc_peak;
        visual_arc_time++;
    }
    else visual_z = 0;

    /* 2-B  CATCH CHECK (collision circle) */
    var wr_hit = collision_circle(x, y, 14, objWRParent, false, false);
    if (wr_hit != noone && !wr_hit.hasBall)
    {
        /* Transfer ball to WR */
        with (wr_hit)
        {
             audio_play_sound(sndCaught2, 1, false);
            caught      = true;
            hasBall     = true;
            run_timer   = 0;
            sprite_index= Player_run_with_ball;
        }

        /* QB drops ownership */
        with (objQB) { attached_to = noone; can_throw = false; }

        /* Attach football */
        attached_to            = wr_hit.id;
        global.player_has_ball = wr_hit.id;

        pass_was_caught        = true;   // <── flag set here

        speed = 0;
        alarm[1] = -1;                   // keep play alive
    }

    /* 2-C  INCOMPLETE PASS: ball lands */
    if (speed > 0 && point_distance(x, y, target_x, target_y) <= speed)
    {
        x = target_x; y = target_y;
        speed = 0; visual_z = 0;
        audio_play_sound(sndCaught, 1, false);
        pass_was_caught = false;        // <── landed, no catch
        global.play_active = false;
        global.player_has_ball = noone;
        alarm[1] = 60;                  // normal reset
    }

    /* 2-D  OUT-OF-BOUNDS */
    var oob = (x < -100) || (x > room_width + 100) ||
              (y < -100) || (y > room_height + 100);

    if (oob && !objQB.playEnded)
    {
        audio_play_sound(sndWhistle, 1, false);

        var new_los_x = x - 40;

        with (objQB)
        {
            playEnded      = true;
            throw_cooldown = 60;
            objScrimmageMarker.x = new_los_x;
            can_throw      = false;
        }

        pass_was_caught = false;        // treat as dead-ball, no gain
        global.play_active     = false;
        global.player_has_ball = noone;
        speed = 0;
    }
}
