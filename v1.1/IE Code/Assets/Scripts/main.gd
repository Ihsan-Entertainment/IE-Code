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


func new_file():
	$TextEdit.text = "Text"
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


func save_file_as_button():
	$SaveFileAs.popup()


func settings_button():
	pass


func credits_button():
	$Credits.popup()


func quit_button():
	get_tree().quit()
