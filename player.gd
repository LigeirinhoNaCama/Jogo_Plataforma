extends CharacterBody2D

const SPEED = 600
const JUMP_VELOCITY = -400
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	var direction = 0.0

	if Input.is_action_pressed("move_right"):
		direction += 1
	if Input.is_action_pressed("move_left"):
		direction -= 1

	velocity.x = direction * SPEED

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()

	# Animações:
	if not is_on_floor():
		anim.play("jump")
	elif direction != 0:
		anim.play("run")
		anim.flip_h = direction < 0  # vira o personagem para esquerda
	else:
		anim.play("idle")
