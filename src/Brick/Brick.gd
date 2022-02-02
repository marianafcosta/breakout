extends KinematicBody2D

class_name Brick

const COLORS = ["red", "orange", "goldenrod", "yellow", "green", "blue"]

var level
var color

func init(_level):
	level = _level
	color = COLORS[_level]
	$Sprite.modulate = ColorN(color)
