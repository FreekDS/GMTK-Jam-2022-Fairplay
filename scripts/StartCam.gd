extends Camera


var tween = Tween.new()

export(NodePath) onready var DiceCam = get_node(DiceCam) as Camera

func _ready():
	tween.connect("tween_completed", self, "change_camera")
	add_child(tween)


func move_to_dicecam():
	tween.follow_property(self, "transform", self.transform, DiceCam, "transform", .5)
	tween.start()

func change_camera(_s, _g):
	self.current = false
	DiceCam.current = true

func _on_Hand_thrown():
	move_to_dicecam()
	pass # Replace with function body.
