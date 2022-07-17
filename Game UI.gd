extends Control

signal target_selected(target)
signal max_sus
signal restart_game()

var selection
var selected = false

export(NodePath) onready var DiceFrame = get_node(DiceFrame) as Sprite


onready var SusMeter = $"SUS Meter"
export(Script) var game_save_class

var game_save = null
var was_sus = false

# Filled by globals
var SUS_increment
var SUS_increment_slowmotion

func _ready():
	
	var g = preload("res://GAME_GLOBALS.tres") as GLOBALS
	SUS_increment = g.sus_increment
	SUS_increment_slowmotion = g.sus_incrment_slowmotion
	SusMeter.connect("reached_max_sus", self, "handle_max_sus")

func handle_max_sus():
	emit_signal("max_sus")
		
func start_select_random_dice_face():
	if not selected:
		$AnimationPlayer.play("dice_select")
		selected = true
		
func random_frame_animation():
	var new_frame = DiceFrame.frame 
	while new_frame == DiceFrame.frame:
		new_frame = randi() % 6
	DiceFrame.frame = new_frame
	selection = new_frame + 1

func animation_ended():
	emit_signal("target_selected", selection)
	
	
func increase_sus(slowmotion):
	if slowmotion:
		SusMeter.add(SUS_increment_slowmotion)
	else:
		SusMeter.add(SUS_increment)


func start_vizual_end_timer(seconds:int):
#	$timer_label.visible=true
	$timer_label.start_timer(seconds)
	
func end():
	load_save()
	$end_game.visible=true
	$gerief.visible=false
	$"SUS Meter".visible=false
#	$timer_label.visible=false
	
	
func lose_game():
	end()
	$end_game/lose.visible=true
	$end_game/restart.disabled=false
	game_save.current_streak=0
	set_score_labels()
	save_save()
	
func win_game():
	end()
	$end_game/win.visible=true
	$end_game/restart.disabled=false
	game_save.current_streak+=1
	if(game_save.current_streak>game_save.highest_streak):
		game_save.highest_streak=game_save.current_streak
	set_score_labels()
	save_save()


func sus_game():
	end()
	$end_game/sus.visible=true
	$end_game/restart.disabled=false
	game_save.current_streak=0
	set_score_labels()
	save_save()
	MusicManager.play_sus_end()
	was_sus = true
	


func set_score_labels():
	$end_game/high_score_label.text="high score: "+str(game_save.highest_streak)
	$end_game/streak_label.text="Current streak: "+str(game_save.current_streak)
	
func enable_blur():
	$blur.visible=true
	

func disable_blur():
	$blur.visible=false


func _on_restart_pressed():
	print("restarting game")
	emit_signal("restart_game")
	if was_sus:
		was_sus = false
		MusicManager.play_random_background()
		

func save_save():
	var dir =Directory.new()
	if not dir.dir_exists("user://saves/"):
		dir.make_dir_recursive("user://saves/")
	ResourceSaver.save("user://saves/save.tres",game_save)
	
func load_save():
	var dir =Directory.new()
	if not dir.dir_exists("user://saves/"):
		print("making new save")
		game_save=game_save_class.new()
		return false
	game_save=load("user://saves/save.tres")
	print("loaded in save with:")
	print("high score: "+str(game_save.highest_streak))
	print("Current streak: "+str(game_save.current_streak))
