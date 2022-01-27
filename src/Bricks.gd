extends Node2D

const BRICK_RESOURCE = preload("res://Brick.tscn")

const H_SCREEN_PADDING = 6

var h_num_of_bricks
var v_num_of_bricks = 6
export var start_pos = Vector2(H_SCREEN_PADDING, 22 + 10) # NOTE: 22 (outside of top wall) + 10 (distance to that wall) 

var sprite_dimensions
var screen_dimensions

func _ready():
	# Instance one brick to check its dimensions then immediately free it
	var instance = BRICK_RESOURCE.instance()
	sprite_dimensions = instance.get_node("Sprite").texture.get_size() * instance.scale
	
	# TODO: I don't think these are the dimensions I want
	screen_dimensions = get_viewport_rect().size
	var h_num_of_bricks_float = (screen_dimensions.x - (H_SCREEN_PADDING * 2)) / sprite_dimensions.x
	h_num_of_bricks = int(round(h_num_of_bricks_float))
	print(h_num_of_bricks)
	spawn_bricks()

func spawn_bricks():
	var v_inc = sprite_dimensions.y
	var h_inc = sprite_dimensions.x
	var pos = start_pos
	var instance
	
	print(v_inc)
	print(h_inc)
	for v in range(v_num_of_bricks):
		for h in range(h_num_of_bricks + 1): # NOTE: +1 to avoid skipping one column of bricks
			instance = BRICK_RESOURCE.instance()
			add_child(instance)
			instance.position = pos
			instance.init(v)
			pos.x += h_inc
		pos = Vector2(start_pos.x, pos.y + v_inc)
