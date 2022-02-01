extends Node2D

signal score_change

const BALL_RESOURCE = preload("res://Ball.tscn")

var score = 0
var lives = 5
var levels_cleared = 0
var game_over = false

var COLORS_TO_POINTS = {
	"blue": 1,
	"green": 2,
	"yellow": 4,
	"goldenrod": 5,
	"orange": 7,
	"red": 8,
}

func _process(_delta):
	if (Input.is_action_just_pressed("ui_restart") && game_over):
		restart()

func restart():
	$UI/GameOverScreen.visible = false
	$UI/Score.text = str(score)
	$UI/Lives.text = str(lives)
	game_over = false
	lives = 5
	score = 0
	instance_ball()

func instance_ball():
	var instance = BALL_RESOURCE.instance()
	add_child(instance)
	move_child(instance, 4)

func _on_Ball_brick_hit(color):
	score += COLORS_TO_POINTS[color]
	$UI/Score.text = str(score)

func _on_Ball_out_of_bounds():
	lives -= 1
	$UI/Lives.text = str(lives)
	if (lives > 0):
		instance_ball()
	else:
		game_over = true
		$UI/GameOverScreen.visible = game_over

func _on_NextLevelTimer_timeout():
	$BouncePad.reset()
	$Bricks.spawn_bricks()
	$Ball.queue_free()
	instance_ball()

func _on_Bricks_wall_cleared():
	if $NextLevelTimer.time_left <= 0 && levels_cleared < 1:
		levels_cleared += 1
		$NextLevelTimer.start()
