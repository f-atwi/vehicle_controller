extends RigidBody3D


const SPEED := 1
const BREAKING_SPEED := 5


func get_point_velocity (point :Vector3)->Vector3:
	return linear_velocity + angular_velocity.cross(point - global_transform.origin)
