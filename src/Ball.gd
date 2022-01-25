extends KinematicBody2D

var velocity = Vector2(50, 50)
var wait_for = 0

func _physics_process(delta):
	# NOTE: https://docs.godotengine.org/en/3.4/tutorials/physics/physics_introduction.html
	if (wait_for > 0):
		$CollisionShape2D.disabled = true
		wait_for -= 1
	else:
		$CollisionShape2D.disabled = false
		
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if (collision_info.collider is Brick):
			collision_info.collider.queue_free()
			
		# TODO: The physics stil aren't quite right
		if (collision_info.collider is BouncePad):
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
			velocity = velocity.bounce(collision_info.normal)
