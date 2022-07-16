extends Control

var tween = Tween.new()
var susTimer = Timer.new()

signal reached_max_sus

export(NodePath) onready var progress = get_node(progress) as TextureProgress

var interpol_time
var finished = false
var susDecay

onready var sus0 = $SusImg
onready var sus1 = $SusImg2
onready var sus2 = $SusImg3

func _ready():
	
	var g = preload("res://GAME_GLOBALS.tres") as GLOBALS
	interpol_time = g.sus_tween_fill_time
	susDecay = g.sus_decay
	
	susTimer.one_shot = false
	susTimer.connect("timeout", self, "decrease")
	
	add_child(susTimer)
	add_child(tween)
	
	susTimer.start(1)

func decrease():
	progress.value -= susDecay

func _process(_delta):
	sus0.shaking = progress.value > 20
	sus1.shaking = progress.value > 60
	sus2.shaking = progress.value > 80
	
		
func fill_to(value):
	if tween.is_active():
		tween.stop_all()
	tween.interpolate_property(progress, "value", progress.value, value, interpol_time, Tween.TRANS_CUBIC)
	tween.start()

func add(value):
	fill_to(progress.value + value)
	if progress.value + value > progress.max_value and not finished:
		tween.connect("tween_all_completed", self, "end")
		finished = true

func end():
	emit_signal("reached_max_sus")
