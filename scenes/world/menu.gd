extends Control

@onready var transition  = $Transition

func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_start_button_pressed():
	transition.play("fade_out")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_options_button_pressed():
	var options = load("res://scenes/world/options.tscn").instantiate()
	get_tree().current_scene.add_child(options)

func _on_transition_animation_finished(anim_name):
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://scenes/main.tscn")
