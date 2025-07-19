/// scr_team_load(fname)
/// —————————————————————————————————————————————
/// Load one JSON file into global.teams under its "team_name" key.

function scr_team_load(fname) {
    var fh, raw, json_data, team_name;

    // Ensure global.teams exists and is a ds_map
    if (!variable_global_exists("teams") || !is_ds_map(global.teams)) {
        global.teams = ds_map_create();
    }

    // Read & parse the file
    fh    = file_text_open_read(fname);
    raw   = file_text_read_string(fh);
    file_text_close(fh);
    json_data = json_parse(raw);

    if (json_data != undefined) {
        team_name = string(json_data[? "team_name"]);
        if (!ds_map_exists(global.teams, team_name)) {
            ds_map_add(global.teams, team_name, json_data);
            show_debug_message("scr_team_load – Loaded “" + team_name + "”");
        } else {
            show_debug_message("scr_team_load – “" + team_name + "” already exists");
        }
    } else {
        show_debug_message("scr_team_load – JSON parse failed for " + fname);
    }
}
