extends Control

signal target_selected(target)

var selection
var selected = false

export(NodePath) onready var DiceFrame = get_node(DiceFrame) as Sprite


onready var SusMeter = $"SUS Meter"


# Filled by globals
var SUS_increment

func _ready():
	
	var g = preload("res://GAME_GLOBALS.tres") as GLOBALS
	SUS_increment = g.sus_increment


func _input(event):
	if event.is_action_pressed("mouse_down") and not selected:
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
