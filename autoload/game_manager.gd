extends Node

var time:float = 0
var max_pos:Vector2
var temp:Array
var max:float
const BHOOT = preload("res://entities/bhoot.tscn")
var has_ghost:bool = false
var can_start:bool = false


func _ready() -> void:
	if get_tree().has_group("spawn"):
		max_pos = get_tree().get_first_node_in_group("spawn").global_position
		max = absf(get_tree().get_first_node_in_group("spawn").global_position.x - get_tree().get_first_node_in_group("player").global_position.x)


func _process(delta: float) -> void:
	time+=delta
	#print(time)
	if has_ghost == false and can_start == true:
		#check_spawn()
		pass
	
func check_spawn():
	if time>=5:
		has_ghost = true
		temp = get_tree().get_nodes_in_group("spawn")
		for i in temp:
			if absf(i.global_position.x - get_tree().get_first_node_in_group("player").global_position.x)>max:
				max_pos = i.global_position
		
		spawn()


func spawn():
	var thongle = BHOOT.instantiate()
	thongle.global_position = max_pos
	add_child(thongle)

func level_start():
	time = 0
	can_start = true
	if get_tree().has_group("spawn"):
		max_pos = get_tree().get_first_node_in_group("spawn").global_position
		max = absf(get_tree().get_first_node_in_group("spawn").global_position.x - get_tree().get_first_node_in_group("player").global_position.x)
