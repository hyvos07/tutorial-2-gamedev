extends Node

const FALL_THRESHOLD_Y = 800.0

@onready var blue_ship: RigidBody2D = $BlueShip

var _ship_start_pos: Vector2
var _resetting := false

func _ready():
	_ship_start_pos = blue_ship.position
	print("Level 1 loaded!")

func _process(_delta):
	if not _resetting and blue_ship and blue_ship.position.y > FALL_THRESHOLD_Y:
		_reset_level()

func _reset_level():
	_resetting = true
	print("Ship fell! Resetting level...")

	# Show reset message
	var label = Label.new()
	label.text = "Ship Lost! Resetting..."
	label.add_theme_font_size_override("font_size", 32)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.set_anchors_preset(Control.PRESET_CENTER)
	label.position = Vector2(-140, -20)
	label.size = Vector2(280, 40)
	label.modulate = Color(1.0, 0.3, 0.3)
	add_child(label)

	await get_tree().create_timer(1.5).timeout
	label.queue_free()

	# Reset ship physics state
	blue_ship.linear_velocity = Vector2.ZERO
	blue_ship.angular_velocity = 0.0
	blue_ship.position = _ship_start_pos
	blue_ship.rotation = 0.0
	blue_ship.freeze = true

	await get_tree().create_timer(0.1).timeout
	blue_ship.freeze = false

	_resetting = false
