extends RayCast3D

func _physics_process(delta):
	if self.is_colliding():
		var collider = self.get_collider()
		print(collider)
