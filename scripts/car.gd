extends RigidBody3D


const SPEED := 100000
const BREAKING_SPEED := 5

var speed: float = 0

@onready var rear_right: RayCast3D = $Suspension/RearRight
@onready var rear_left: RayCast3D = $Suspension/RearLeft
	


func _process(delta: float) -> void:
	if Input.is_action_pressed("Gas"):
		apply_force_on_both_wheels(-basis.x * SPEED * delta)

func apply_force_on_both_wheels(force: Vector3) -> void:
	apply_force_on_node_position(force, rear_right)
	apply_force_on_node_position(force, rear_left)

func apply_force_on_node_position(force: Vector3, node: Node3D) -> void:
	apply_force(force, node.global_position - global_position)
