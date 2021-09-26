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

	window_settings()
	textedit_settings()


func window_settings():
	# $Settings/WindowSize resets window size to 960x540 if pressed
	OS.window_resizable = $Settings/Resizable.pressed
	OS.window_fullscreen = $Settings/Fullscreen.pressed
#	OS.? = $Settings/AlwaysOnTop.pressed
	OS.vsync_enabled = $Settings/Vsync.pressed


func textedit_settings():
	$TextEdit.highlight_current_line = $Settings/HighlightCurrentLine.pressed
	$TextEdit.syntax_highlighting = $Settings/SyntaxHighlighting.pressed
	$TextEdit.highlight_current_line = $Settings/HighlightCurrentLine.pressed
	$TextEdit.show_line_numbers = $Settings/LineNumbers.pressed
	$TextEdit.draw_tabs = $Settings/DrawTabs.pressed
	$TextEdit.draw_spaces = $Settings/DrawSpaces.pressed
	$TextEdit.breakpoint_gutter = $Settings/BreakpointGutter.pressed
	$TextEdit.fold_gutter = $Settings/FoldGutter.pressed
	$TextEdit.highlight_all_occurrences = $Settings/HighligtAllOccurrences.pressed
	$TextEdit.minimap_draw = $Settings/Minimap.pressed


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


func save_file_as(path):
	var file = File.new()
	file.open(path, 2)
	file.store_string($TextEdit.text)
	current_path = path


func save_file_as_button():
	$SaveFileAs.popup()


func credits_button():
	$Credits.popup()


func quit_button():
	get_tree().quit()
