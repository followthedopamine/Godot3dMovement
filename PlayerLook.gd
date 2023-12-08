extends RayCast3D

@onready var hover_tooltip := $/root/Main/HUD/HoverTooltip
@onready var object_label := $/root/Main/HUD/HoverTooltip/ObjectLabel

func _physics_process(delta):
	if is_colliding():
		var collider := get_collider()
		var tooltip = collider.get_parent().get_node_or_null("Tooltip")
		if tooltip != null:
			object_label.text = tooltip.label
			hover_tooltip.set_visible(true)
		else:
			hover_tooltip.set_visible(false)
	else:
		hover_tooltip.set_visible(false)

	
