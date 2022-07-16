extends Spatial

var thrown = false

export(Environment) var normal_env = null
export(Environment) var dof_env = null

onready var dice=$Dice
onready var table=$Table
onready var dice_cam=$DiceCam
onready var world_env=$WorldEnvironment


func _ready():
	dice.connect("slow_motion_state_changed",self,"change_to_slowmotion")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if not thrown:
			$Hand.throw()
			thrown = true

func change_to_slowmotion(is_slowmotion:bool):
	if is_slowmotion:
		print("Going to slow motion mode")
		table.bounce_value=1200
		dice_cam.fov=50
		world_env.environment=dof_env
	else :
		print("Going to normal motion mode")
		table.bounce_value=400
		dice_cam.fov=90
		world_env.environment=normal_env
		
	

