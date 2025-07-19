/// scr_team_boot()
/// —————————————————————————————————————————————
/// 1) Ensure the on-disk “teams/” folder exists
/// 2) Destroy any old map
/// 3) Create a fresh global.teams ds_map
/// 4) Load every “*.json” in that folder
/// 5) Build global.team_list[] from the map’s keys

function scr_team_boot() {
    // 1) On-disk folder
    var dir = working_directory + "teams/";
    if (!directory_exists(dir)) {
        directory_create(dir);
    }

    // 2) & 3) Reset the map
    if (variable_global_exists("teams") && is_ds_map(global.teams)) {
        ds_map_destroy(global.teams);
    }
    global.teams = ds_map_create();

    // 4) Load each JSON
    var fname = file_find_first(dir + "*.json", fa_readonly);
    while (fname != "") {
        scr_team_load(dir + fname);
        fname = file_find_next();
    }
    file_find_close();

    // 5) Build the name list
    global.team_list = [];
    var key = ds_map_find_first(global.teams);
    while (key != undefined) {
        array_push(global.team_list, key);
        key = ds_map_find_next(global.teams, key);
    }
}
