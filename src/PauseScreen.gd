extends Control

func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		var tree = get_tree()
		tree.paused = !tree.paused
		visible = tree.paused
