extends StaticBody


var bounce_value=400

var hits = 0

func _ready():
	set_bounce(
		0
	)

func _on_Area_body_entered(body):
	if body.is_in_group("dice"):
		if hits == 0:
			body.add_force(Vector3.UP * bounce_value, Vector3.ZERO)
		hits += 1
		