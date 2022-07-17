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
	dice.connect("second_bounce_hit",self,"stop_game_after_time")
	game_ui.connect("restart_game",self,"restart")
	game_ui.connect("max_sus", self, "stop_game", [true])
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
		dice_cam.fov = globals.slowmotion_fov
		game_ui.enable_blur()
		
#		world_env.environment = dof_env
	else :
#		print("Going to normal motion mode")
		dice_cam.fov = globals.normal_fov
		game_ui.disable_blur()
#		world_env.environment = normal_env
		
	
func stop_game_after_time():
	stop_game_timer.wait_time = globals.end_game_timer
	game_ui.start_vizual_end_timer(second_bounce_leftover_seconds)
	stop_game_timer.wait_time = second_bounce_leftover_seconds
	stop_game_timer.one_shot = true
	stop_game_timer.start()

var ended = false
func stop_game(sus = false):
	if ended:
		return
	ended = true
	dice.disable()
	
	if sus:
		game_ui.sus_game()
		return
	
	print(dice.current_top_number)
	if(dice.current_top_number==game_ui.selection):
		print("goed")
		game_ui.win_game()
	else:
		print("niet goed")
		game_ui.lose_game()
		
func restart():
	get_tree().reload_current_scene() 
	
func _on_Dice_foefelen(in_slowmotion):
	$Game_UI.increase_sus(in_slowmotion)
