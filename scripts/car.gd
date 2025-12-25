extends RigidBody3D


const SPEED := 1000
const BREAKING_SPEED := 5

var speed: float = 0

@onready var rear_right: RayCast3D = $Suspension/RearRight
@onready var rear_left: RayCast3D = $Suspension/RearLeft

var forward := false

func _process(delta: float) -> void:
	forward = Input.is_action_pressed("Gas")

func _physics_process(delta: float) -> void:
	if forward:
		var force = -basis.x * SPEED
		apply_force_on_both_wheels(force)

func apply_force_on_both_wheels(force: Vector3) -> void:
	apply_force_on_node_position(force, rear_right)
	apply_force_on_node_position(force, rear_left)

func apply_force_on_node_position(force: Vector3, node: Node3D) -> void:
	apply_force(force, node.global_position - global_position)
