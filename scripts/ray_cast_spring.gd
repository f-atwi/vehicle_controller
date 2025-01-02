extends RayCast3D

@export var stiffness: float = 35300
@export var damp_strength: float = 10
@onready var rigid_body_3d: RigidBody3D = $".."
var previous_length: float = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_colliding():
		var length: float = get_collision_point().distance_to(global_position)
		var dist := 1-length
		var speed = (previous_length - length)/delta
		rigid_body_3d.apply_force(dist*stiffness*transform.basis.y, global_position)
		previous_length = length
		print(dist)
	else:
		previous_length = 1
		
