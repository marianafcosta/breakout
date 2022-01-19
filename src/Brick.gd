extends KinematicBody2D

class_name Brick

const COLORS = ["red", "orange", "goldenrod", "yellow", "green", "blue"]
var own_color

func init(level):
	own_color = COLORS[level]
	$Sprite.modulate = ColorN(own_color)
