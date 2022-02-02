extends KinematicBody2D

signal top_wall_hit
signal brick_hit
signal out_of_bounds

var velocity = Vector2(0, 0)
var wait_for = 0

var hits_num = 0
var orange_contact = false
var red_contact = false

var screen_dimensions

func _ready():
	screen_dimensions = get_viewport_rect().size
	position = Vector2(screen_dimensions.x / 2, screen_dimensions.y / 2 + 10)
	self.connect("top_wall_hit", get_tree().root.get_node("Root/BouncePad"), "_on_Ball_top_wall_hit")
	self.connect("brick_hit", get_tree().root.get_node("Root"), "_on_Ball_brick_hit")
	self.connect("out_of_bounds", get_tree().root.get_node("Root"), "_on_Ball_out_of_bounds")

func _physics_process(delta):
	if (position.y > screen_dimensions.y + $Sprite.texture.get_height()): # TODO these dimensions arent correct because of the scaling i think
		emit_signal("out_of_bounds")
		queue_free()
	# So that collisions aren't negated because they last for more than one cycle
	if (wait_for > 0):
		$CollisionShape2D.disabled = true
		wait_for -= 1
	else:
		$CollisionShape2D.disabled = false
		
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if (collision_info.collider.name == "WallUp"):
			emit_signal("top_wall_hit")
		
		var prev_hits_num = hits_num
		if (collision_info.collider is Brick):
			$HitBrick.play()
			collision_info.collider.queue_free()
			hits_num += 1
			emit_signal("brick_hit", collision_info.collider.color)
			if (collision_info.collider.color == "orange" && !orange_contact):
				orange_contact = true
				velocity *= 1.1
			elif(collision_info.collider.color == "red" && !red_contact):
				red_contact = true
				velocity *= 1.1
			
		# TODO: The physics stil aren't quite right
		if (collision_info.collider is BouncePad):
			$HitBouncePad.play()
			wait_for = 5
			# Get the position of the collision in global coordinates
			var collision_pos = collision_info.position
			# Get the position of the (center of the) paddle
			var collider_pos = collision_info.collider.position
			# Calculate the difference between the collision point and the center of the paddle for the X direction
			var diff_collision_collider = collision_pos - collider_pos
			# Define three distance intervals (left, center, and right third)
			# ___|___|___
			var first_div = collider_pos.x - 8 + 6 
			var second_div = first_div + 6
			var angle_direction_to_normal = collision_info.remainder.normalized().angle_to(Vector2(0, -1))
			if (collision_pos.x < first_div): # Left
				if (angle_direction_to_normal > 0):
					velocity = velocity.bounce(collision_info.normal)
				else:
					velocity = -velocity
			elif (collision_pos.x >= first_div && collision_pos.x < second_div): # Middle
				velocity = velocity.bounce(collision_info.normal)
			else: # Right
				if (angle_direction_to_normal > 0):
					velocity = -velocity
				else:
					velocity = velocity.bounce(collision_info.normal)
		else:
			$HitWall.play()
			velocity = velocity.bounce(collision_info.normal)
		
		if (
			prev_hits_num < 4 && hits_num == 4 ||
			prev_hits_num < 12 && hits_num == 12
		):
			velocity *= 1.1

func _on_Timer_timeout():
	velocity = Vector2(75, 75)
