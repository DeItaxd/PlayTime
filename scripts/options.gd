extends Control

func _on_back_pressed():
		get_tree().current_scene.remove_child(self)

func _ready():
	$VBoxContainer/Back.grab_focus()
