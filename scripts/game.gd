extends Spatial

var thrown = false

onready var dice=$Dice
onready var table=$Table


func _ready():
	dice.connect("slow_motion_state_changed",self,"change_bounce_value_to_slowmotion")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if not thrown:
			$Hand.throw()
			thrown = true

func change_bounce_value_to_slowmotion(is_slowmotion:bool):
	if is_slowmotion:
		print("bounce going to 1200")
		table.bounce_value=1200
	else :
		print("bounce going back to 400")
		table.bounce_value=400
		
	

