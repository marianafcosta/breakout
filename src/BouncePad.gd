extends KinematicBody2D

class_name BouncePad

export var speed = 350
var velocity = Vector2(speed, 0)
var original_scale

var top_wall_hit = false

func _ready():
	original_scale = self.scale

# NOTE: https://www.informit.com/articles/article.aspx?p=2180417&seqNum=2
# This article describes the paddle physics in detail
func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("ui_right"):
		direction = 1
	if Input.is_action_pressed("ui_left"):
		direction = -1
	var collision_info = move_and_collide(direction * velocity * delta)

func reset():
	set_scale(original_scale)
	top_wall_hit = false

func _on_Ball_top_wall_hit():
	if not top_wall_hit:
		set_scale(Vector2(self.scale.x * 0.75, self.scale.y))
		top_wall_hit = true
