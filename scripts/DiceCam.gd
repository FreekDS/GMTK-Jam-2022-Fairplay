extends Camera


export(NodePath) onready var dice = get_node(dice) as Spatial
export(Vector3) var diceOffset = Vector3.ZERO

func _ready():
	translation = dice.translation + diceOffset
	
func _process(_delta):
	translation = dice.translation + diceOffset


