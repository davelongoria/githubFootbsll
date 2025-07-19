/// scr_team_unload_all()
/// Destroys any existing globals before rebuilding.
function scr_team_unload_all() {
    if (variable_global_exists("teams") && is_ds_map(global.teams)) {
        ds_map_destroy(global.teams);
        variable_global_unset("teams");
    }
    if (variable_global_exists("team_list")) {
        variable_global_unset("team_list");
    }
}

/// scr_team_load_all()
/// ————————————————————————————————————————
/// 1) Clear out old data
/// 2) Create a fresh global.teams map
/// 3) Load every *.json in working_directory\teams\
/// 4) Build global.team_list[] from the map’s keys
function scr_team_load_all() {
    // 1) clear out anything left over
    scr_team_unload_all();

    // 2) create a new map
    global.teams = ds_map_create();

    // 3) find & load every .json in working_directory\teams\
    var pattern = working_directory + "teams\\" + "*.json";
    var fname   = file_find_first(pattern, 0);  // mask + attributes
    while (fname != "") {
        var full = working_directory + "teams\\" + fname;
        scr_team_load(full);
        fname = file_find_next();
    }
    file_find_close();

    // 4) build a simple array of team names for your UI
    global.team_list = [];
    var key = ds_map_find_first(global.teams);
    while (key != undefined) {
        array_push(global.team_list, key);
        // ← Pass the previous key here:
        key = ds_map_find_next(global.teams, key);
    }
}
