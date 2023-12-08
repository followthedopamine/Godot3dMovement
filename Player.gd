extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var jump_force := 1000
var can_jump := true

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot

func _ready():
	self.connect("body_entered", on_body_entered)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta):
	handle_movement(delta) # These should probably be moved to input
	handle_rotation()
	jump()

func _input(event: InputEvent) -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventMouseMotion:
		#if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		twist_input = - event.relative.x * mouse_sensitivity
		pitch_input = - event.relative.y * mouse_sensitivity

func on_body_entered(body: Node3D):
	if "floor" in body.name.to_lower():
		can_jump = true

func handle_movement(delta) -> void:
	var input = Vector3.ZERO
	
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_backward")
	
	apply_central_force(twist_pivot.basis * input * 1200.0 * delta)

func handle_rotation() -> void:
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, 
		deg_to_rad(-30), 
		deg_to_rad(30)
	)
	twist_input = 0.0
	pitch_input = 0.0
	
func jump() -> void:
	if Input.is_action_pressed("jump") and can_jump:
		apply_central_force(Vector3(0, jump_force, 0))
		can_jump = false
