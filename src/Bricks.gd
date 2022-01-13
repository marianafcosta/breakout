extends Node2D

const BRICK_RESOURCE = preload("res://Brick.tscn")

const H_DIST_BETWEEN_BRICKS = 20
const V_DIST_BETWEEN_BRICKS = 20
const H_SCREEN_PADDING = 50

var h_num_of_bricks
var v_num_of_bricks = 5
export var start_pos = Vector2(H_SCREEN_PADDING, 50)

var width_sprite
var height_sprite
var screen_dimensions

func _ready():
	# TODO Hardocoded for now, but change to calculating the dimensions according to the resource's sprite
	width_sprite = 20
	height_sprite = 10
	screen_dimensions = get_viewport_rect().size
	# TODO This calculation isn't correct
	# __[   ]__
	# I should assume a single brick is composed of the sprite width, along with the padding to the left and right of it
	# Then, when placing the bricks, the starting position should not be the edge of the render zone and should instead
	# take into consideration the padding to the left of the brick, as well as half of the brick's width
	var h_num_of_bricks_float = (screen_dimensions.x - (H_SCREEN_PADDING * 2)) / (width_sprite + H_DIST_BETWEEN_BRICKS)
	h_num_of_bricks = int(round(h_num_of_bricks_float))
	print(h_num_of_bricks)
	spawn_bricks()

func spawn_bricks():
	var v_inc = height_sprite + H_DIST_BETWEEN_BRICKS
	var h_inc = width_sprite + H_DIST_BETWEEN_BRICKS
	var pos = start_pos
	var instance
	
	for v in range(v_num_of_bricks):
		for h in range(h_num_of_bricks):
			pos.x += h_inc
			instance = BRICK_RESOURCE.instance()
			add_child(instance)
			instance.position = pos
		pos = Vector2(start_pos.x, pos.y + v_inc)
	pass
