/// @description Insert description here
// You can write your code in this editor
//draw_self();





if (!can_throw) {
    draw_text(x, y - 48, "QB Cooldown: " + string(ceil(throw_cooldown / 30)) + "s");
} else if (key_held != -1) {
    draw_text(x, y - 48, "Charging " + string(throw_charge));
}


var sc = 1;
shader_set(shdPaletteTex);
draw_sprite_ext(sprite_index, image_index, x, y, sc, sc, 0, c_white, 1);
shader_reset();