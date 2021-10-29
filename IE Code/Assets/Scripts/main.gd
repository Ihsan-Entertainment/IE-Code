extends Control


var current_path = "no path set"


func _process(delta):
	if Input.is_action_pressed("New File"):
		new_file()
	if Input.is_action_pressed("Open File"):
		open_file_button()
	if Input.is_action_pressed("Save File"):
		save_file_button()
	if Input.is_action_pressed("Save File As"):
		save_file_as_button()
	if Input.is_action_pressed("Settings"):
		settings_button()
	if Input.is_action_pressed("Cancel") and $Settings/TabContainer/Window/Fullscreen.pressed == true:
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
	if $Settings/TabContainer/Autosave/AutoSaving.pressed == true: 
		$AutoSave.start(0.001)
	else:
		$AutoSave.stop()


func autosave():
		var file = File.new()
		file.open(current_path, 2)
		file.store_string($TextEdit.text)


func settings_button():
	$Settings.popup()


func new_file():
	$TextEdit.text = ""
	current_path = "no path set"


func open_file(path):
	print(path)
	var file = File.new()
	file.open(path, 1)
	current_path = path
	$TextEdit.text = file.get_as_text()


func open_file_button():
	$OpenFile.popup()


func save_file_button():
	if current_path == "no path set":
		save_file_as_button()
	else:
		var file = File.new()
		file.open(current_path, 2)
		file.store_string($TextEdit.text)
		$SavedDialog.popup()


func save_file_as(path):
	var file = File.new()
	file.open(path, 2)
	file.store_string($TextEdit.text)
	current_path = path
	$SavedDialog.popup()


func save_file_as_button():
	$SaveFileAs.popup()


func credits_button():
	$Credits.popup()


func quit_button():
	get_tree().quit()
