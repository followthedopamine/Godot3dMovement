extends RayCast3D

var current_colliding_surface: MeshInstance3D
var previous_colliding_surface: MeshInstance3D
var surface_sound_type: String
@onready var body := get_parent().get_parent()
@onready var footstep_sound := $FootstepSound

var grass_sounds := [
	preload('res://Sounds/Footsteps/Grass/Footsteps_Walk_Grass_Mono_01.wav'),
	preload('res://Sounds/Footsteps/Grass/Footsteps_Walk_Grass_Mono_02.wav'),
	preload('res://Sounds/Footsteps/Grass/Footsteps_Walk_Grass_Mono_03.wav'),
	preload('res://Sounds/Footsteps/Grass/Footsteps_Walk_Grass_Mono_04.wav'),
	preload('res://Sounds/Footsteps/Grass/Footsteps_Walk_Grass_Mono_05.wav'),
	preload('res://Sounds/Footsteps/Grass/Footsteps_Walk_Grass_Mono_06.wav'),
	preload('res://Sounds/Footsteps/Grass/Footsteps_Walk_Grass_Mono_07.wav'),
	preload('res://Sounds/Footsteps/Grass/Footsteps_Walk_Grass_Mono_08.wav'),
]
var water_sounds := [
	preload('res://Sounds/Footsteps/Water/Footsteps_WaterV1_Walk_01.wav'),
	preload('res://Sounds/Footsteps/Water/Footsteps_WaterV1_Walk_02.wav'),
	preload('res://Sounds/Footsteps/Water/Footsteps_WaterV1_Walk_03.wav'),
	preload('res://Sounds/Footsteps/Water/Footsteps_WaterV1_Walk_04.wav'),
	preload('res://Sounds/Footsteps/Water/Footsteps_WaterV1_Walk_05.wav'),
	preload('res://Sounds/Footsteps/Water/Footsteps_WaterV1_Walk_06.wav'),
	preload('res://Sounds/Footsteps/Water/Footsteps_WaterV1_Walk_07.wav'),
	preload('res://Sounds/Footsteps/Water/Footsteps_WaterV1_Walk_08.wav'),
]

func _physics_process(_delta):
	play_footstep_sound()

func get_ground_object():
	if is_colliding():
		var collider = get_collider()
		if current_colliding_surface != collider.get_parent() and collider.get_parent() is MeshInstance3D:
			return collider.get_parent()

func is_moving():
	if (body.linear_velocity.x > 0.1 or body.linear_velocity.x < -0.1 
	or body.linear_velocity.y > 0.1 or body.linear_velocity.y < -0.1):
		return true

func set_footstep_sound(): # Need to work out how to do a switch statement for something like this
	if current_colliding_surface != null:
		if "grass" in current_colliding_surface.name.to_lower():
			footstep_sound.stream = grass_sounds[randi() % grass_sounds.size()]
		if "water" in current_colliding_surface.name.to_lower():
			footstep_sound.stream = water_sounds[randi() % water_sounds.size()]

func play_footstep_sound():
	if is_colliding() and is_moving():
		current_colliding_surface = get_ground_object()
		if current_colliding_surface == null:
			return
		if current_colliding_surface != previous_colliding_surface:
			previous_colliding_surface = current_colliding_surface
			footstep_sound.stop()
		if !footstep_sound.playing:
			set_footstep_sound()
			footstep_sound.play()

# This doesn't quite work, the footstep plays when the player is slowing down to a stop
