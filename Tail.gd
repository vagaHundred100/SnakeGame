extends Area2D

const SPEED = 40
var direction = Vector2(0,0)


		
		
func betten():
	get_tree().change_scene("res://Game Over.tscn")
	
	
func _on_Tail_area_entered(area):
	if area.has_method("betten"):
		area.betten()
