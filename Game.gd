extends Node2D

export (PackedScene) var Gelly
var screen_hight = 600
var screen_width = 1040

func _ready():
	randomize()
	gelly_set_pos()


func gelly_set_pos():
	while true:
		var check = 0
		var x = int(rand_range(0,screen_width - 40))
		var y = int(rand_range(0,screen_hight - 40))
		x = x - x % 40
		y = y - y % 40
		for tail in $Sneak.get_children():
			if tail.position == Vector2(x,y):
				check += 1
		if check == 0 :
			$Gelly.position = Vector2(x,y)
			break


func _on_Gelly_area_entered(area):
	$Sneak.add_tail()
	gelly_set_pos()
	
	
