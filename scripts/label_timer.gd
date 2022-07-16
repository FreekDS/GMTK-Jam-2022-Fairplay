extends RichTextLabel



var show_timer = Timer.new()

var time_left
var delta=0.1

func _ready():
	show_timer.connect("timeout",self,"timer_step")
# Called when the node enters the scene tree for the first time.
func start_timer(seconds:int):
	time_left=seconds
	show_timer.wait_time = delta
	add_child(show_timer)
	show_timer.start()
func timer_step():
	time_left-=delta
	if(time_left>0):
		show_timer.start()
		self.text=str(str(time_left)+"s left")
	else:
		self.text=str("Time up")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
