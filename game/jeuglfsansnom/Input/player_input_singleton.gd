extends Node


func does_player_press_jump() -> bool:
	return Input.is_action_just_pressed("jump")


func does_player_press_use_magic_stick() -> bool:
	return Input.is_action_just_pressed("use_magic_stick")


func does_player_select_magic_stick() -> bool:
	return Input.is_action_just_pressed("select_magic_stick")


func does_player_select_magic_freeze() -> bool:
	return Input.is_action_just_pressed("select_magic_freeze")


func does_player_select_magic_fire() -> bool:
	return Input.is_action_just_pressed("select_magic_fire")


func get_player_left_or_right_direction() -> float:
	return Input.get_axis("move_left", "move_right")
