extends CenterContainer


signal text_completed

export var fadeTime = 4
export(String, MULTILINE) var text


var completed = false
var playing = false

onready var TextLabel = $panel as RichTextLabel
onready var tween = $Tween

var fade_amount = 0
var max_fade

func _ready():
	max_fade = text.length()
	TextLabel.bbcode_text = "[center]" + text
	TextLabel.visible_characters = 0
	tween.connect("tween_completed", self, "end")


func play():
	tween.interpolate_property(TextLabel, "visible_characters", 0, max_fade, fadeTime)
	tween.start()
	playing = true


func skip():
	if tween.is_active():
		tween.stop_all()
	TextLabel.visible_characters = -1
	end(null, null)
	
func end(_s, _g):
	print("kleir")
	completed = true
	playing = false
	emit_signal("text_completed")
