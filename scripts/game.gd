extends Spatial

var thrown = false

var stop_game_timer = Timer.new()

export(Environment) var normal_env = null
export(Environment) var dof_env = null

onready var dice=$Dice
onready var table=$Table
onready var dice_cam=$DiceCam
onready var world_env=$WorldEnvironment
onready var game_ui=$Game_UI

var second_bounce_leftover_seconds=3

var globals = preload("res://GAME_GLOBALS.tres") as GLOBALS


func _ready():
	add_child(stop_game_timer)
	dice.connect("slow_motion_state_changed",self,"change_to_slowmotion")
	table.connect("second_bounce_hit",self,"stop_game_after_time")
	game_ui.connect("restart_game",self,"restart")
	stop_game_timer.connect("timeout",self,"stop_game")
	randomize()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if not thrown:
			$Hand.throw()
			thrown = true
			game_ui.start_select_random_dice_face()

func change_to_slowmotion(is_slowmotion:bool):
	if is_slowmotion:
#		print("Going to slow motion mode")
		table.bounce_value = globals.dice_bounce_base * globals.dice_bounce_slowmotion_multiplier
		dice_cam.fov= globals.slowmotion_fov
		world_env.environment=dof_env
	else :
#		print("Going to normal motion mode")
		table.bounce_value= globals.dice_bounce_base
		dice_cam.fov= globals.normal_fov
		world_env.environment=normal_env
		
	
func stop_game_after_time():
	stop_game_timer.wait_time = globals.end_game_timer
	game_ui.start_vizual_end_timer(second_bounce_leftover_seconds)
	stop_game_timer.wait_time = second_bounce_leftover_seconds
	stop_game_timer.one_shot = true
	stop_game_timer.start()

func stop_game():
	dice.disable()
	print(dice.current_top_number)
	if(dice.current_top_number==game_ui.selection):
		print("goed")
		game_ui.lose_game()
	else:
		print("niet goed")
		game_ui.lose_game()
		
func restart():
	get_tree().reload_current_scene() 
	

	
	
