extends Control


var current_path = "no path set"


func _process(delta):
	if Input.is_action_pressed("new_file"):
		new_file_button()
		new_file_button()
	if Input.is_action_pressed("open_file"):
		open_file_button()
	if Input.is_action_pressed("save_file"):
		save_file_button()
	if Input.is_action_pressed("save_file_as"):
		save_file_as_button()
	if Input.is_action_pressed("settings"):
		settings_button()
	if Input.is_action_just_pressed("fullscreen") and $Settings/TabContainer/Window/Fullscreen.pressed == false:
		$Settings/TabContainer/Window/Fullscreen.pressed = true
	if Input.is_action_pressed("cancel") and $Settings/TabContainer/Window/Fullscreen.pressed == true:
		$Settings/TabContainer/Window/Fullscreen.pressed = false

	window_settings()
	textedit_settings()
	autosave_settings()


func window_settings():
	if current_path == "no path set":
		OS.set_window_title("IE Code - Unsaved File")
	else:
		OS.set_window_title("IE Code" + " - " + current_path)

	OS.window_borderless = $Settings/TabContainer/Window/Borderless.pressed
	OS.keep_screen_on = $Settings/TabContainer/Window/EnergySaving.pressed
	OS.window_resizable = $Settings/TabContainer/Window/Resizable.pressed
	OS.window_fullscreen = $Settings/TabContainer/Window/Fullscreen.pressed


func textedit_settings():
	$TextEdit.highlight_current_line = $Settings/TabContainer/TextEdit/HighlightCurrentLine.pressed
	$TextEdit.highlight_all_occurrences = $Settings/TabContainer/TextEdit/HighligtAllOccurrences.pressed
	$TextEdit.syntax_highlighting = $Settings/TabContainer/TextEdit/SyntaxHighlighting.pressed
	$TextEdit.show_line_numbers = $Settings/TabContainer/TextEdit/LineNumbers.pressed
	$TextEdit.draw_tabs = $Settings/TabContainer/TextEdit/DrawTabs.pressed
	$TextEdit.draw_spaces = $Settings/TabContainer/TextEdit/DrawSpaces.pressed
	$TextEdit.breakpoint_gutter = $Settings/TabContainer/TextEdit/BreakpointGutter.pressed
	$TextEdit.fold_gutter = $Settings/TabContainer/TextEdit/FoldGutter.pressed
	$TextEdit.smooth_scrolling = $Settings/TabContainer/TextEdit/SmoothScrolling.pressed
	$TextEdit.minimap_draw = $Settings/TabContainer/TextEdit/Minimap.pressed


func autosave_settings():
	if $Settings/TabContainer/AutoSave/AutoSaving.pressed == true: 
		$AutoSave.start(0.001)
	else:
		$AutoSave.stop()


func autosave():
		var file = File.new()
		file.open(current_path, 2)
		file.store_string($TextEdit.text)


func settings_button():
	$Settings.popup_centered()


func new_file():
	$TextEdit.text = ""
	current_path = "no path set"
	print("New file created.")


func new_file_button():
	$ConfirmNewFile.popup_centered()


func open_file(path):
	var file = File.new()
	file.open(path, 1)
	current_path = path
	$TextEdit.text = file.get_as_text()

	print("File opened:")
	print(path)


func open_file_button():
	$OpenFile.popup_centered()


func save_file_button():
	if current_path == "no path set":
		save_file_as_button()
	else:
		var file = File.new()
		file.open(current_path, 2)
		file.store_string($TextEdit.text)
		$SavedDialog.popup_centered()

	print("File saved:")
	print(current_path)


func save_file_as(path):
	var file = File.new()
	file.open(path, 2)
	file.store_string($TextEdit.text)
	current_path = path
	$SavedDialog.popup_centered()

	print("File saved as:")
	print(path)


func save_file_as_button():
	$SaveFileAs.popup_centered()


func about_button():
	$About.popup_centered()


func quit_button():
	$ConfirmQuit.popup_centered()


func confirm_quit():
	get_tree().quit()


func website():
	OS.shell_open("https://github.com/Ihsan-Entertainment/IE-Code")


func report_bug():
	OS.shell_open("https://github.com/Ihsan-Entertainment/IE-Code/issues/new")
