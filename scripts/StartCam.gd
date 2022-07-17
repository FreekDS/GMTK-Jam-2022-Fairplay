extends Camera


var tween = Tween.new()

export(NodePath) onready var DiceCam = get_node(DiceCam) as Camera
#export(NodePath) onready var DiceCamEffect = get_node(DiceCamEffect) as Control
export(NodePath) onready  var Trail = get_node(Trail) as Node2D

var tween_duration

func _ready():
	var g = preload("res://GAME_GLOBALS.tres") as GLOBALS
	tween_duration = g.move_to_dicecam_time
	tween.connect("tween_completed", self, "change_camera")
	add_child(tween)


func move_to_dicecam():
	tween.follow_property(self, "transform", self.transform, DiceCam, "transform", tween_duration)
	tween.start()

func change_camera(_s, _g):
	self.current = false
	DiceCam.current = true

func _on_Hand_thrown():
	move_to_dicecam()
#	DiceCamEffect.visible = false
	Trail.visible = true
