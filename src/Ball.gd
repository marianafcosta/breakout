extends KinematicBody2D

var velocity = Vector2(250, 250)

# NOTE: https://docs.godotengine.org/en/3.4/tutorials/physics/physics_introduction.html
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
