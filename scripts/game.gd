extends Spatial

var thrown = false

var stop_game_timer = Timer.new()

export(Environment) var normal_env = null
export(Environment) var dof_env = null

onready var dice=$Dice
onready var table=$Table
onready var dice_cam=$DiceCam
onready var world_env=$WorldEnvironment


func _ready():
	dice.connect("slow_motion_state_changed",self,"change_to_slowmotion")
	table.connect("second_bounce_hit",self,"stop_game_after_time")
	stop_game_timer.connect("timeout",self,"stop_game")
	randomize()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if not thrown:
			$Hand.throw()
			thrown = true

func change_to_slowmotion(is_slowmotion:bool):
	if is_slowmotion:
		print("Going to slow motion mode")
		table.bounce_value=1800
		dice_cam.fov=50
		world_env.environment=dof_env
	else :
		print("Going to normal motion mode")
		table.bounce_value=600
		dice_cam.fov=90
		world_env.environment=normal_env
		
	
func stop_game_after_time():
	stop_game_timer.wait_time = 2
	stop_game_timer.one_shot = true
	add_child(stop_game_timer)
	stop_game_timer.start()

func stop_game():
	dice.disable()
	print(dice.current_top_number)
	
