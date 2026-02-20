extends Area2D

@export var next_level_path: String = "res://scenes/MainLevel.tscn"
@export var accepted_ship_name: String = "GreenShip"

var _victory_shown := false

func _on_ObjectiveArea_body_entered(body: RigidBody2D):
	if body.name == accepted_ship_name and not _victory_shown:
		_victory_shown = true
		_show_victory_and_transition()

func _show_victory_and_transition():
	# Freeze the ship
	var ship = get_tree().current_scene.find_child(accepted_ship_name, true, false)
	if ship:
		if ship.has_method("set_movement_locked"):
			ship.set_movement_locked(true)
		ship.freeze = true

	# Create victory label
	var label = Label.new()
	label.text = "Level Complete!"
	label.add_theme_font_size_override("font_size", 48)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.set_anchors_preset(Control.PRESET_CENTER)
	label.position = Vector2(-150, -30)
	label.size = Vector2(300, 60)
	label.modulate = Color(0.2, 1.0, 0.3)
	get_tree().current_scene.add_child(label)

	# Wait then transition
	await get_tree().create_timer(2.0).timeout

	get_tree().change_scene_to_file(next_level_path)
