extends Node2D

@export var speed = 500.0

func _ready():
	print("Green Platform initialized")

func _process(delta):
	if Input.is_action_pressed("move_up"):
		move_local_y(-speed * delta, false)
	
	if Input.is_action_pressed("move_down"):
		move_local_y(speed * delta, false)
	
	if Input.is_action_pressed("move_left"):
		move_local_x(-speed * delta, false)
		
	if Input.is_action_pressed("move_right"):
		move_local_x(speed * delta, false)
