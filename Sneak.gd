extends Node2D


export (PackedScene) var Tail
var direction = Vector2(1,0)
const TAIL_SIZE = 40
const DELAY = 5
var delay = 0
var Turns = {}
var check_button = ""


func _ready():
	set_head()
	
	
func _process(delta):
	set_direction()
	if DELAY == delay:
		move_sneak()
		move_tails()
		cross_border()
		delay = 0
	delay +=1
	

func set_head():
	var tail = Tail.instance()
	tail.position.x += 7 * TAIL_SIZE
	tail.direction = direction
	add_child(tail)

	
func add_tail():
	var last_tail_num = get_child_count() - 1
	var tail = Tail.instance()
	var last_tail_dir = get_child(last_tail_num).direction
	var last_tail_pos = get_child(last_tail_num).position
	tail.direction = last_tail_dir
	tail.position = Vector2(last_tail_pos.x - last_tail_dir.x*TAIL_SIZE,
		last_tail_pos.y - last_tail_dir.y * TAIL_SIZE)
	add_child(tail)


func move_sneak():
	var pos = get_child(0).position
	Turns[pos] = direction
	for tail in get_children():
		 var turn = Turns.get(tail.position)
		 if turn != null:
				tail.direction = turn
			

func set_direction():
	if(Input.is_action_pressed("Left") and
		check_button != "Wright"):
		direction = Vector2(-1,0)
		check_button = "Left"
		
	elif(Input.is_action_pressed("Wright") and
		check_button != "Left"):
		direction = Vector2(1,0)
		check_button = "Wright"
		
	elif(Input.is_action_pressed("Up") and 
		check_button != "Down"):
		direction = Vector2(0,-1)
		check_button = "Up"
		
	elif(Input.is_action_pressed("Down") and
		check_button != "Up"):
		direction = Vector2(0,1)
		check_button = "Down"
	print(get_child(0).position)


func move_tails():
	for tail in get_children():
		tail.position += tail.direction * tail.SPEED


func cross_border():
	for tail in get_children():
		if tail.position.x < 0:
			tail.position.x = get_viewport_rect().size.x - TAIL_SIZE
			tail.direction = Vector2(-1,0)
		elif tail.position.x > get_viewport_rect().size.x - TAIL_SIZE :
			tail.position.x = 0
			tail.direction  = Vector2(1,0)
		elif tail.position.y < 0 :
			tail.position.y = get_viewport_rect().size.y - TAIL_SIZE
			tail.direction  = Vector2(0,1)
		elif tail.position.y > get_viewport_rect().size.y - TAIL_SIZE:
			tail.position.y = 0
			tail.direction = Vector2(0,-1)



