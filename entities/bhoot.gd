extends CharacterBody2D

var is_detected:bool = false

enum state {spawn=1,search_right=2,search_left=3,chase=4,go_back=5}

var target_right:float

var target_left:float

var kalu:Vector2

var is_calculate:bool = false
var prev_state:int
var current_state:int
var next_state:int

var max_pos:Vector2
var temp:Array
var max:float
var time:float = 0

@export var speed:float= 10000

var player:CharacterBody2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	next_state = state.spawn
	kalu = player.global_position
	max_pos = get_tree().get_first_node_in_group("spawn").global_position
	max = absf(get_tree().get_first_node_in_group("spawn").global_position.x - get_tree().get_first_node_in_group("player").global_position.x)
	
func _physics_process(delta: float) -> void:
	prev_state = current_state
	current_state = next_state
	
	
	match current_state:
		state.search_right:
			search_right(delta)
		state.search_left:
			search_left(delta)
		state.chase:
			chase(delta)
		state.go_back:
			go_back(delta)
		state.spawn:
			spawn(delta)
			

	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()	


func _on_dectect_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print(body)
		time = 0
		is_calculate = false
		next_state = state.chase
		

func search_right(delta):
	time+=delta
	if time<10.0:
		if absf(target_right - global_position.x) <= 2:
			target_left = randf_range(global_position.x-200,global_position.x-75)
			next_state = state.search_left
		velocity.x = signum(target_right - global_position.x)*delta*speed
	else:
		next_state = state.go_back
	
func chase(delta):
	velocity.x = (player.position - position).normalized().x*delta*speed
	
func search_left(delta):
	time+=delta
	if time<10.0:
		if absf(target_left - global_position.x) <= 2:
			target_right = randf_range(global_position.x+75,global_position.x+200)
			next_state = state.search_right
		velocity.x = signum(target_left - global_position.x)*delta*speed
	else:
		next_state = state.go_back
	

func signum(alu:float):
	if alu>0:
		print("signum = "+str(alu))
		return 1
		
	elif alu<0:
		print("signum = "+str(alu))
		return -1
		
	else:
		return 0


func _on_lose_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		target_right = randf_range(global_position.x+75,global_position.x+200)
		next_state = state.search_right


func go_back(delta):
	temp = get_tree().get_nodes_in_group("spawn")
	if is_calculate == false:
		for i in temp:
			if absf(i.global_position.x - player.global_position.x)>max:
				max_pos = i.global_position
	is_calculate = true
	velocity.x = signum(max_pos.x - global_position.x)*delta*speed
	if absf(max_pos.x - global_position.x) <= 2:
		GameManager.time = 0
		GameManager.has_ghost = false
		queue_free()


func spawn(delta):
	if absf(kalu.x - global_position.x) <= 2:
		target_right = randf_range(global_position.x+75,global_position.x+200)
		next_state = state.search_right
	velocity.x = signum(kalu.x - global_position.x)*delta*speed
