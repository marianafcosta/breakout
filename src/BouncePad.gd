extends KinematicBody2D

export var speed = 50
var velocity = Vector2(speed, 0)

func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("ui_right"):
		direction = 1
	if Input.is_action_pressed("ui_left"):
		direction = -1
	var collision_info = move_and_collide(direction * velocity * delta)
