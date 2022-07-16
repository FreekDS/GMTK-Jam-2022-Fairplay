extends RichTextLabel


var texts = [
	'"Time is money the farmer said, and he sold his watch"\n-Ghandi',
	"'Has anyone seen my guitar?'\n-Tom Dice",
	'"Some illegal coins a day keep the taxes away"\n-J. Jones',
	'"It is free real estate"\n-D. Trump',
	'"One more for the books"',
	'"Cloudy with a chance of fake news"\n-CNN Wheater Forecast',
	'"Money, it never comes easy, but now it could!"\nSome ad',
	'"EZ OUTPLAYED"\n-LoL players',
	'"Money Money Money, it is so funny, in a rich mans world"\n-Some music group',
	'"Music by Klaus Wunderlich"\n-Klaus Wunderlich'
]


func _change_text():
	var i = randi() % len(texts)
	text = texts[i]
