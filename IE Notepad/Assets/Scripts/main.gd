extends Control


func _ready():
	pass


func _process(delta):
	if Input.is_action_just_pressed("Menu"):
		$Menu.popup()


func _on_MenuButton_pressed():
	$Menu.popup()


func _on_NewFileButton_pressed():
	get_tree().reload_current_scene()


func _on_OpenFileButton_pressed():
	$OpenFileDialog.popup()


func _on_OpenFileDialog_file_selected(path):
	print(path)
	var file = File.new()
	file.open(path, 1)
	$TextEdit.text = file.get_as_text()


func _on_SaveAsButton_pressed():
	$SaveAsDialog.popup()


func _on_SaveAsDialog_file_selected(path):
	var file = File.new()
	file.open(path, 2)
	file.store_string($TextEdit.text)


func _on_AboutButton_pressed():
	$About.popup()


func _on_GitHub_pressed():
	OS.shell_open("https://github.com/Ihsan-Entertainment/IE-Code")


func _on_GodotEngine_pressed():
	$GodotEngine.popup()
