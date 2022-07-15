extends RigidBody

#todo zet slowmo af voor landing voor bounciness te fixen

var mouse_down_start

export var torque_power = 6.0

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("mouse_down"):
		mouse_down_start = get_viewport().get_mouse_position()
	if event.is_action_released("mouse_down"):
		var dir: Vector2 = get_viewport().get_mouse_position() - mouse_down_start
		dir = dir.normalized()
		add_torque(Vector3(dir.y, 0, -dir.x) * torque_power);
	if event.is_action_pressed("slowmo"):
		Engine.time_scale = .3
	if event.is_action_released("slowmo"):
		Engine.time_scale = 1
	
	



func _on_Hand_thrown():
	add_force(Vector3(-150, 100, 0), Vector3(0,0,0))
	add_torque(Vector3(randf(), randf(), randf()) * 10)
