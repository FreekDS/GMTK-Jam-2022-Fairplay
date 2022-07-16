extends RigidBody

#todo zet slowmo af voor landing voor bounciness te fixen

var mouse_down_start

export var torque_power = 6.0
export var slowmotion_torque_power = 15.0

export var clamp_velocity = 7
onready var ray = $RayCast

var slow_motion = false

var enabled=true

var current_top_number=2

signal slow_motion_state_changed(is_slowmotion)
var counter=0
func _process(delta):
	ray.set_cast_to(linear_velocity.normalized())
	var ding=self.get_global_transform().basis
	#print(ding)
	if(ding.x[2]<0.1 and ding.x[2]>-0.1):
		if(ding.x[1]<1.1 and ding.x[1]>0.9):
			current_top_number=6
		else:
			current_top_number=5
	if(ding.y[2]<0.1 and ding.y[2]>-0.1):
		if(ding.y[1]<1.1 and ding.y[1]>0.9):
			current_top_number=2
		else:
			current_top_number=4
			
	if(ding.z[2]<0.1 and ding.z[2]>-0.1):
		if(ding.z[1]<1.1 and ding.z[1]>0.9):
			current_top_number=3
		else:
			current_top_number=1
	#Vector2(ding.x, ding.z).angle()

	
func _integrate_forces(state):
	state.angular_velocity.x = clamp(state.angular_velocity.x, -clamp_velocity, clamp_velocity)
	state.angular_velocity.z = clamp(state.angular_velocity.z, -clamp_velocity, clamp_velocity)

func _input(event):
	if(enabled):
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
	add_force(Vector3(-350, 100, 0), Vector3(0,0,0))
	add_torque(Vector3(randf(), randf(), randf()) * 10)
	
func disable():
	self.set_physics_process(false)
	enabled=false
	if(slow_motion):
		Engine.time_scale = 1
		slow_motion = false
		emit_signal("slow_motion_state_changed", false)
