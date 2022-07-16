extends RigidBody

#todo zet slowmo af voor landing voor bounciness te fixen

var mouse_down_start

export var torque_power = 6.0
export var slowmotion_torque_power = 15.0


const max_throw_power = 1000
const min_throw_power = 300
const throw_height = 100
const torque_multiplier = 15

export var clamp_velocity = 7
onready var ray = $RayCast

var slow_motion = false

signal slow_motion_state_changed(is_slowmotion)

func _process(_delta):
	ray.set_cast_to(linear_velocity.normalized())

	
func _integrate_forces(state):
	state.angular_velocity.x = clamp(state.angular_velocity.x, -clamp_velocity, clamp_velocity)
	state.angular_velocity.z = clamp(state.angular_velocity.z, -clamp_velocity, clamp_velocity)

func _input(event):
	if event.is_action_pressed("mouse_down"):
		mouse_down_start = get_viewport().get_mouse_position()
	if event.is_action_released("mouse_down"):
		var dir: Vector2 = get_viewport().get_mouse_position() - mouse_down_start
		dir = dir.normalized()
		var power = torque_power
		if slow_motion:
			power = slowmotion_torque_power
		
		add_torque(Vector3(dir.y, 0, -dir.x) * power);
	if event.is_action_pressed("slowmo"):
		Engine.time_scale = .3
		slow_motion = true
		emit_signal("slow_motion_state_changed", true)
	if event.is_action_released("slowmo"):
		Engine.time_scale = 1
		slow_motion = false
		emit_signal("slow_motion_state_changed", false)


func _on_Hand_thrown():
	
	var throw_power = rand_range(min_throw_power, max_throw_power)
	var torque = Vector3(
		rand_range(-1, 1),
		rand_range(-1, 1),
		rand_range(-1, 1)
	)
	
	add_force(Vector3(-throw_power, throw_height, 0), Vector3(0,0,0))
	add_torque(torque * torque_multiplier)
