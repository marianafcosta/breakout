extends Node2D

const BRICK_RESOURCE = preload("res://Brick.tscn")

const H_SCREEN_PADDING = 4

var h_num_of_bricks
var v_num_of_bricks = 5
export var start_pos = Vector2(H_SCREEN_PADDING, 22 + 10) # NOTE: 22 (outside of top wall) + 10 (distance to that wall) 

var width_sprite
var height_sprite
var screen_dimensions

func _ready():
	# TODO Hardocoded for now, but change to calculating the dimensions according to the resource's sprite
	width_sprite = 8
	height_sprite = 2
	screen_dimensions = get_viewport_rect().size
	var h_num_of_bricks_float = (screen_dimensions.x - (H_SCREEN_PADDING * 2)) / width_sprite
	h_num_of_bricks = int(round(h_num_of_bricks_float))
	print(h_num_of_bricks)
	spawn_bricks()

func spawn_bricks():
	var v_inc = height_sprite
	var h_inc = width_sprite
	var pos = start_pos
	var instance
	
	for v in range(v_num_of_bricks):
		for h in range(h_num_of_bricks + 1): # NOTE: +1 to avoid skipping one column of bricks
			instance = BRICK_RESOURCE.instance()
			add_child(instance)
			instance.position = pos
			pos.x += h_inc
		pos = Vector2(start_pos.x, pos.y + v_inc)
