extends RigidBody2D

@export var move_speed: float = 300.0
@export var rotate_with_movement: bool = true
@export var rotation_speed: float = 5.0

var _movement_locked := false

func _ready():
	print("Ship ready!")
	gravity_scale = 0.0
	can_sleep = false
	lock_rotation = true

func _physics_process(_delta):
	if _movement_locked:
		linear_velocity = Vector2.ZERO
		return

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	linear_velocity = input_dir * move_speed

	if rotate_with_movement and input_dir.length() > 0.0:
		rotation = input_dir.angle() + PI / 2.0

func set_movement_locked(value: bool):
	_movement_locked = value
	if _movement_locked:
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0
