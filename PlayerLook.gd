extends RayCast3D

@onready var hover_tooltip := $/root/Main/HUD/HoverTooltip
@onready var object_label := $/root/Main/HUD/HoverTooltip/ObjectLabel
var collider = null

func _physics_process(delta) -> void:
	if is_colliding():
		collider = get_collider()
		show_tooltip()
		interact()
	else:
		hover_tooltip.set_visible(false)

func show_tooltip() -> void:
	var tooltip = collider.get_parent().get_node_or_null("Tooltip")
	if tooltip != null:
		object_label.text = tooltip.label
		hover_tooltip.set_visible(true)
	else:
		hover_tooltip.set_visible(false)

func interact() -> void:
	if Input.is_action_pressed("interact"):
		var action = collider.get_parent().get_node_or_null("Interact")
		if action != null:
			action.interact()
		
