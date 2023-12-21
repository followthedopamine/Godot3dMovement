extends Node3D

@onready var animation_player = get_node("../../RedButtonAnimationPlayer")

func interact():
	var button = get_parent()
	animation_player.play("ButtonPress")
