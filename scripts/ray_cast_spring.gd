extends RayCast3D

#@export var damp_strength: float = 10
@export var car_frequency: float = 1.5 # Range 1Hz to 2Hz
@export var x_preload_fraction: float = 0.5 # Range .5 to .75
@export var spring_natural_length: float = 0.4 # Range .25 to .50
@export var wheel_radius: float = 0.2 # Range .18m to .25m  
@export var damping_coefficient = 1 # should be studied for its value

var previous_length: float
var stiffness: float
var x_equilibrium: float
var x_preloaded: float
var spring_length: float

@onready var rigid_body_3d: RigidBody3D = $"../.."


func _ready() -> void:
	stiffness = pow(TAU * car_frequency, 2) * (rigid_body_3d.mass / 4) # Assuming equal mass distribution on all wheels
	previous_length = spring_length
	x_equilibrium = ProjectSettings.get_setting("physics/3d/default_gravity") / pow(TAU * car_frequency, 2)
	spring_length = spring_natural_length - x_preload_fraction*x_equilibrium
	target_position.y = -spring_length - wheel_radius # must be adjusted with wheel size
	# Check that equilibium is less that spring length 
	assert (x_equilibrium < spring_natural_length)
	assert (x_equilibrium < spring_length)

	
func _physics_process(delta: float) -> void:
	if is_colliding():
		var length: float = clamp(get_collision_point().distance_to(global_position) - wheel_radius, 0, spring_length)	
		var delta_x := spring_natural_length - length
		var speed = (previous_length - length) / delta
		rigid_body_3d.apply_force(delta_x*(stiffness+speed*damping_coefficient)*transform.basis.y, global_position)
		previous_length = length
	else:
		previous_length = spring_length
		
