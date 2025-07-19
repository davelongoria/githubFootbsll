/// scr_seed_teams(_dir)
/*
    Re-creates the starter files so the menu always has
    at least two valid teams to show (good for first runs
    and for rescuing a corrupted /teams folder).
*/
function scr_seed_teams(_dir)
{
    // make sure the folder itself exists and is empty
    if (directory_exists(_dir))
        directory_destroy(_dir);
    directory_create(_dir);

    // ---------- team #1  ----------
    var tpl = {
        "team_name" : "TEMPLATE",
        "city"      : "Nowhere",
        "colours"   : [0xFFFFFF, 0x000000],
        "roster"    : [
            { "name":"QB Example", "pos":"QB", "ovr":75 }
        ]
    };

    // ---------- team #2  ----------
    var demo = {
        "team_name" : "Pixel Pros",
        "city"      : "Example",
        "colours"   : [0x3498DB, 0xE74C3C],
        "roster"    : [
            { "name":"QB Demo",  "pos":"QB",  "ovr":70 },
            { "name":"WR Demo",  "pos":"WR",  "ovr":68 }
        ]
    };

    // write both files – we always overwrite because this
    // script is only called when we KNOW we need fresh seeds.
    var fh = file_text_open_write(_dir + "TEMPLATE.json");
    file_text_write_string(fh, json_stringify(tpl, true));
    file_text_close(fh);

    fh = file_text_open_write(_dir + "example.json");
    file_text_write_string(fh, json_stringify(demo, true));
    file_text_close(fh);

    show_debug_message("scr_seed_teams — seeds recreated.");
}
