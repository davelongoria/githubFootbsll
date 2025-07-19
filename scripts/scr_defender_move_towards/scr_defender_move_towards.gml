function scr_defender_move_towards(target_x, target_y, move_speed) {
    var dir = point_direction(x, y, target_x, target_y);
    var next_x = x + lengthdir_x(move_speed, dir);
    var next_y = y + lengthdir_y(move_speed, dir);

    if (!place_meeting(next_x, next_y, obj_offensive_lineman)) {
        x = next_x;
        y = next_y;
    } else {
        var angles = [15, -15, 30, -30];
        var moved = false;
        for (var i = 0; i < array_length(angles); i++) {
            var new_dir = dir + angles[i];
            next_x = x + lengthdir_x(move_speed, new_dir);
            next_y = y + lengthdir_y(move_speed, new_dir);
            if (!place_meeting(next_x, next_y, obj_offensive_lineman)) {
                x = next_x;
                y = next_y;
                moved = true;
                break;
            }
        }
        if (!moved) {
            speed = 0;
        }
    }
}
