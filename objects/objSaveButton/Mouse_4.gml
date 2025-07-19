/// objSaveButton – Mouse Left Pressed
//--------------------------------------------------------------
// 0. click-sound
if (audio_exists(sndSelect)) audio_play_sound(sndSelect, 0, false);

//--------------------------------------------------------------
// 1.  Build palette CSV   ($RRGGBB,$RRGGBB,…)
var palette_str = "";
for (var i = 0; i < array_length(global.current_pal); ++i) {
    palette_str += scr_color_to_hex(global.current_pal[i]);
    if (i < array_length(global.current_pal) - 1) palette_str += ",";
}

//--------------------------------------------------------------
// 2.  Collect TEAM-INFO  (Name | City | Abbr | LogoFrame)
var teamname = string_trim(global.team_name);
if (teamname == "") teamname = "New Team";

var info_name = teamname;
var info_city = string_trim(global.team_city);
var info_abbr = string_trim(global.team_abbr);
var info_logo = (variable_global_exists("logo_frame")) ? global.logo_frame : 0;

// store in RAM for the session
scr_teaminfo_set(teamname, info_name, info_city, info_abbr, info_logo);

// chunk that goes into the palettes file
var info_str = info_name + "|" + info_city + "|" + info_abbr + "|" + string(info_logo);

//--------------------------------------------------------------
// 3.  Update / rewrite palettes.txt
var base_dir  = game_save_id;            // <-- new, project-independent
if (!directory_exists(base_dir)) directory_create(base_dir);

var file_path = base_dir + "palettes.txt";

var lines = ds_list_create();

// read existing file (if any)
if (file_exists(file_path)) {
    var fh_in = file_text_open_read(file_path);
    while (!file_text_eof(fh_in)) {
        ds_list_add(lines, file_text_read_string(fh_in));
        file_text_readln(fh_in);
    }
    file_text_close(fh_in);
}

// remove any old line for this team
for (var idx = ds_list_size(lines) - 1; idx >= 0; --idx) {
    var _line = lines[| idx];                               //  ← renamed
    if (string_copy(_line, 1, string_length(teamname)) == teamname &&
        string_pos(":", _line) > 0)
    {
        ds_list_delete(lines, idx);
    }
}

// append fresh line
ds_list_add(lines, teamname + ":" + palette_str + "|||" + info_str);

// write everything back
var fh_out = file_text_open_write(file_path);
for (var k = 0; k < ds_list_size(lines); ++k) {             // ← counter renamed
    file_text_write_string(fh_out, lines[| k]);
    file_text_writeln(fh_out);
}
file_text_close(fh_out);
ds_list_destroy(lines);

show_debug_message("Saved palette + info for \"" + teamname + "\"");

//--------------------------------------------------------------
// 4.  Return to team-select
room_goto(RM_TeamSelect);
