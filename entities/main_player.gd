extends CharacterBody2D

enum State {IDLE, RUNNING, HIDING, INTERACTING, TRAPPED}
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var acceleration: float = 650
var deceleration: float = 800
var top_speed: int = 112

var player_state: State

var health: int = 100

func _ready():
	player_state = State.IDLE
	velocity = Vector2(0, 0)
	sprite_2d.flip_h=true


func _physics_process(delta):
	print(player_state)

	match (player_state):
		State.IDLE:
			sprite_2d.play("idle")
			if Input.is_action_pressed("left"):
				velocity.x -= delta * acceleration
				player_state = State.RUNNING
			elif Input.is_action_pressed("right"):
				velocity.x += delta * acceleration
				player_state = State.RUNNING

		State.RUNNING:
			sprite_2d.play("run")
			if Input.is_action_pressed("left"):
				sprite_2d.flip_h = false
				velocity.x -= delta * acceleration
			elif Input.is_action_pressed("right"):
				sprite_2d.flip_h = true
				velocity.x += delta * acceleration
			else: # decelerating
				if velocity.x > 0:
					velocity.x -= delta * deceleration
					velocity.x = clampf(velocity.x, 0, top_speed)
				else:
					velocity.x += delta * deceleration
					velocity.x = clampf(velocity.x, -top_speed, 0)

			velocity.x = clampf(velocity.x, -top_speed, top_speed)
			if (velocity.x == 0):
				player_state = State.IDLE
				
		State.INTERACTING:
			sprite_2d.play("interact")
			
		_:
			pass
	move_and_slide()

func take_damage(thing: String):
	match thing:
		"bear":
			health -= 30
		"bomb":
			health -= 80
