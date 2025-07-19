/// scr_team_save(team) ➜ writes/over-writes <working_dir>/teams/<name>.json
///
/// @param {struct} team – struct with at least .name and .palette[]
///
function scr_team_save(team)
{
    if (!is_struct(team) || !variable_struct_exists(team, "name")) return false;

    var base_dir = working_directory + "teams/";
    if (!directory_exists(base_dir)) directory_create(base_dir);

    var fname = base_dir + string(team.name) + ".json";
    string_save(fname, json_encode(team, true));   // pretty=TRUE for readability
    return true;
}
