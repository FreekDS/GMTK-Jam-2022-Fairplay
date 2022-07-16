extends Control

signal target_selected(target)
signal restart_game()

var selection
var selected = false

export(NodePath) onready var DiceFrame = get_node(DiceFrame) as Sprite


onready var SusMeter = $"SUS Meter"


# Filled by globals
var SUS_increment

func _ready():
	
	var g = preload("res://GAME_GLOBALS.tres") as GLOBALS
	SUS_increment = g.sus_increment


		
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
	
	
func increase_sus():
	SusMeter.add(SUS_increment)


func start_vizual_end_timer(seconds:int):
	$timer_label.visible=true
	$timer_label.start_timer(seconds)
	
func end():
	$end_game.visible=true
	$gerief.visible=false
	$"SUS Meter".visible=false
	$timer_label.visible=false
	
	
func lose_game():
	end()
	$end_game/lose.visible=true
	$end_game/restart.disabled=false
	
func win_game():
	end()
	$end_game/win.visible=true
	$end_game/restart.disabled=false

func _on_restart_pressed():
	print("restarting game")
	emit_signal("restart_game")
