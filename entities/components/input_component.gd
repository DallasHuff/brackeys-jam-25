class_name InputComponent
extends Node

@export var receiver: Node2D
var enabled := true


func _physics_process(_delta: float) -> void:
	var move_dir := Vector2.ZERO
	move_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	# Basically a deadzone
	if receiver.has_method("move_input") && move_dir.length() > 0.05:
		receiver.move_input(move_dir)

	var shoot_dir := get_shoot_dir()
	if receiver.has_method("cast") && shoot_dir.length() > 0.05:
		receiver.cast(shoot_dir)


func get_shoot_dir() -> Vector2:
	var shoot_dir := Vector2.ZERO
	shoot_dir.x = Input.get_action_strength("shoot_right") - Input.get_action_strength("shoot_left")
	shoot_dir.y = Input.get_action_strength("shoot_down") - Input.get_action_strength("shoot_up")
	return shoot_dir
