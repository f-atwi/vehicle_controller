extends RigidBody3D


const SPEED := 100000
const BREAKING_SPEED := 5

var speed: float = 0

@onready var rear_right: RayCast3D = $Suspension/RearRight
@onready var rear_left: RayCast3D = $Suspension/RearLeft
	


func _process(delta: float) -> void:
	if Input.is_action_pressed("Gas"):
		apply_force_on_both_wheels(-transform.basis.x * SPEED * delta)

func apply_force_on_both_wheels(force: Vector3) -> void:
	apply_force_on_node_position(force, rear_right)
	apply_force_on_node_position(force, rear_left)

func apply_force_on_node_position(force: Vector3, node: Node3D) -> void:
	apply_force(force, node.position)

func get_point_velocity (point :Vector3)->Vector3:
	return linear_velocity + angular_velocity.cross(point - global_transform.origin)
