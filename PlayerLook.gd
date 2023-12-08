extends RayCast3D

@onready var object_label := $/root/Main/HUD/ObjectLabel

func _physics_process(delta):
	if is_colliding():
		var collider := get_collider()
		print(collider.get_parent().name)
		if "button" in collider.get_parent().name.to_lower():
			object_label.set_visible(true)
		else:
			object_label.set_visible(false)
		
