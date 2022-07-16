extends Control

var tween = Tween.new()

export(NodePath) onready var progress = get_node(progress) as TextureProgress

func _ready():
	add_child(tween)
	
# problem: update tween when is running does not work as intended

func fill_to(value):
	if tween.is_active():
		tween.stop_all()
	tween.interpolate_property(progress, "value", progress.value, value, .5, Tween.TRANS_CUBIC)
	tween.start()

func add(value):
	fill_to(progress.value + value)
