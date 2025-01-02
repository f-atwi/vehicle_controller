extends Node3D


var mouse_sensitivity: float = .01

@onready var car: RigidBody3D = $"../Car"


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y += -event.relative.x * mouse_sensitivity
		rotation.z = clamp(rotation.z - event.relative.y * mouse_sensitivity, 0, PI/2)
		print(rotation.z - event.relative.y * mouse_sensitivity)
