extends Control



func _on_Credits_pressed():
	$MainMenu.visible = false
	$Credits.visible = true


func _on_BackButton_pressed():
	$MainMenu.visible=true
	$Credits.visible=false


func _on_PlayButton_pressed():
	get_tree().change_scene("res://game.tscn")


func _on_italian_pressed():
	$MainMenu/Handjeintro.visible=false
	$MainMenu/Handjeintro_it.visible=true
	


func _on_world_pressed():
	$MainMenu/Handjeintro.visible=true
	$MainMenu/Handjeintro_it.visible=false
