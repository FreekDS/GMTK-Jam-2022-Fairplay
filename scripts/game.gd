extends Spatial

var thrown = false

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if not thrown:
			$Hand.throw()
			thrown = true



