/// scr_team_unload()
function scr_team_unload() {
    if (variable_global_exists("teams") && is_ds_map(global.teams)) {
        ds_map_destroy(global.teams);
        variable_global_unset("teams");
    }
    if (variable_global_exists("team_list")) {
        variable_global_unset("team_list");
    }
}
