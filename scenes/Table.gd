extends StaticBody


var hits = 0

func _ready():
	set_bounce(.7)

func _on_Area_body_entered(body):
	if body.is_in_group("dice"):
		set_bounce(0)
		hits += 1
		print("jep")
