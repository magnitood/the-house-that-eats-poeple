extends CharacterBody2D

enum State {IDLE, RUNNING, HIDING, INTERACTING}

var acceleration: float
var deceleration: float
var top_speed: int
var player_state: State

func _ready():
	player_state = State.IDLE
	velocity = Vector2(0, 0)

func _physics_process(delta):
	match (player_state):
		State.IDLE:
			if Input.is_action_just_pressed("left"):
				player_state = State.RUNNING
				velocity.x += delta * acceleration
			elif Input.is_action_just_pressed("right"):
				velocity.x -= delta * acceleration

		State.RUNNING:
			var direction: int
	move_and_slide()
