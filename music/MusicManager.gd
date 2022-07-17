extends Node
class_name Music


var dont_get_me_started = false


func _ready():
	randomize()
	play_random_background()
	
	for child in $Background.get_children():
		child.connect("finished", self, "play_random_background")

func play_sus_end():
	stop_all()
	$SusEnd.play()
	

func stop_all():
	for child in $Background.get_children():
		child = child as AudioStreamPlayer
		if child.playing:
			child.stop()
			dont_get_me_started = true
			print("stop")
	if $SusEnd.playing:
		$SusEnd.stop()


func play_random_background():
	if dont_get_me_started:
		dont_get_me_started = false
		return
	stop_all()
	var i = randi() % $Background.get_child_count()
	print("HHHH" + str(i))
	$Background.get_child(i).play()
 
