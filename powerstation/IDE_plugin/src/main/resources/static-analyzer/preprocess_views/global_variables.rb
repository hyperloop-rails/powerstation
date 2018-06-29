$app_name = ""
$path_prefix = ""
$view_folder_name = "views"
$new_view_folder_name = "ruby_views"
$extract_ruby_script = "./extract_ruby"
$view_dir = ""
$view_files = Hash.new

$only_generate_nextcall_pathfunc = false
$only_generate_nextcall = false

$path_funcs = Hash.new

$routes_file = ""
$controller_dir = ""
$new_controller_dir = ""
$helper_dir = ""
$new_helper_dir = ""
$next_action_dir = ""
$controller_folder_name = "controllers"
$new_controller_folder_name = "merged_controllers"
$helper_folder_name = "helpers"
$new_helper_folder_name = "merged_helpers"
$actions = Hash.new
$controllers = Hash.new
#This if purely for easier searh purpose...
$controller_names_downcase = Array.new
$helpers = Hash.new
$cur_class = nil
$cur_action = nil
$has_helper = false

$node_stack = nil
