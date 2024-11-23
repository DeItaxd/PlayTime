extends WorldEnvironment

var dark = false

@onready var sky = $".".environment

func _on_player_voided():
	if !dark:
		pass
