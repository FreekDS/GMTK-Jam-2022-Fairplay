extends Control

var tween = Tween.new()

signal reached_max_sus

export(NodePath) onready var progress = get_node(progress) as TextureProgress

var interpol_time

func _ready():
	
	var g = preload("res://GAME_GLOBALS.tres") as GLOBALS
	interpol_time = g.sus_tween_fill_time
	
	add_child(tween)
	
# problem: update tween when is running does not work as intended

func fill_to(value):
	if tween.is_active():
		tween.stop_all()
	tween.interpolate_property(progress, "value", progress.value, value, interpol_time, Tween.TRANS_CUBIC)
	tween.start()

func add(value):
	fill_to(progress.value + value)
