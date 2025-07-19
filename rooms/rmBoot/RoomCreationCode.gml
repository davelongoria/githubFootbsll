/// rmBoot → Create Event
scr_team_boot();


// Make sure all global lists/maps are created
if (!variable_global_exists("logo_sprites")) global.logo_sprites = ds_list_create();
if (!variable_global_exists("team_list")) global.team_list = ds_list_create();
if (!variable_global_exists("roster_list")) global.roster_list = ds_list_create();

// Make mod folders (safe on all platforms)
var base_dir = working_directory;
var folders = ["logos", "teams", "rosters", "extras"];
for (var i = 0; i < array_length(folders); i++) {
    var f = folders[i];
    if (!directory_exists(base_dir + f)) directory_create(base_dir + f);
}
// Make sure the palettes map exists right away
scr_palette_init("Default");   // builds global.team_palettes, pal_surf, etc.

//scr_palette_init("Default"); // Or any valid team name you know is always present
if (!surface_exists(global.pal_surf_away))
    global.pal_surf_away = surface_create(1,1);

if (!surface_exists(global.pal_surf))
    global.pal_surf = surface_create(1,1);     // home (already created once, but safe)

// Load custom logos and anything else
//scr_load_custom_logos();
//show_debug_message(get_user_directory());
