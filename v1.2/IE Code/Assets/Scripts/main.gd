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

	settings()


func settings():
	if $Settings/HighlightCurrentLine.pressed == true:
		$TextEdit.highlight_current_line = true
	else:
		$TextEdit.highlight_current_line = false

	if $Settings/SyntaxHighlighting.pressed == true:
		$TextEdit.syntax_highlighting = true
	else:
		$TextEdit.syntax_highlighting = false

	if $Settings/LineNumbers.pressed == true:
		$TextEdit.show_line_numbers = true
	else:
		$TextEdit.show_line_numbers = false

	if $Settings/DrawTabs.pressed == true:
		$TextEdit.draw_tabs = true
	else:
		$TextEdit.draw_tabs = false

	if $Settings/DrawSpaces.pressed == true:
		$TextEdit.draw_spaces = true
	else:
		$TextEdit.draw_spaces = false

	if $Settings/LineMarker.pressed == true:
		$TextEdit.breakpoint_gutter = true
	else:
		$TextEdit.breakpoint_gutter = false

	if $Settings/FoldGutter.pressed == true:
		$TextEdit.fold_gutter = true
	else:
		$TextEdit.fold_gutter = false

	if $Settings/HighligtAllOccurrences.pressed == true:
		$TextEdit.highlight_all_occurrences = true
	else:
		$TextEdit.highlight_all_occurrences = false

	if $Settings/Minimap.pressed == true:
		$TextEdit.minimap_draw = true
	else:
		$TextEdit.minimap_draw = false


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
