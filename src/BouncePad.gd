extends KinematicBody2D

class_name BouncePad

export var speed = 125
var velocity = Vector2(speed, 0)

# NOTE: https://www.informit.com/articles/article.aspx?p=2180417&seqNum=2
# This article describes the paddle physics in detail
func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("ui_right"):
		direction = 1
	if Input.is_action_pressed("ui_left"):
		direction = -1
	var collision_info = move_and_collide(direction * velocity * delta)
