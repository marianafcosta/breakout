extends Node2D

signal score_change

var score = 0

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
