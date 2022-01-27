extends Node2D

signal score_change

const BALL_RESOURCE = preload("res://Ball.tscn")

var score = 0
var lives = 5

var COLORS_TO_POINTS = {
	"blue": 1,
	"green": 2,
	"yellow": 4,
	"goldenrod": 5,
	"orange": 7,
	"red": 8,
}

func _on_Ball_brick_hit(color):
	score += COLORS_TO_POINTS[color]
	$UI/Score.text = str(score)


func _on_Ball_out_of_bounds():
	lives -= 1
	$UI/Lives.text = str(lives)
	if (lives > 0):
		var instance = BALL_RESOURCE.instance()
		add_child(instance)
		instance.position = Vector2(160, 90)
