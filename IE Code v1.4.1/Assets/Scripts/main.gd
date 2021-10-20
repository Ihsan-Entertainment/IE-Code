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
	autosave_settings()


func window_settings():
	OS.set_window_title($Settings/WindowTitle.text)
	OS.window_resizable = $Settings/Resizable.pressed
	OS.window_fullscreen = $Settings/Fullscreen.pressed


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
	$TextEdit.smooth_scrolling = $Settings/SmoothScrolling.pressed
	$TextEdit.minimap_draw = $Settings/Minimap.pressed


func autosave_settings():
	if $Settings/AutoSaving.pressed == true: 
		$AutoSave.start(0.001)
		autosave()
	else:
		$AutoSave.stop()


func autosave():
# only if current_path != "no path set"
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
