class_name FollowCamera
extends Camera2D

## Target the camera should follow
var _target: Node2D

## Enable/disable clamping
@export var use_bounds: bool = true

@export var bounds: Rect2 = Rect2(-960, -540, 1920, 1080)
@export var lerp_speed: float = 0  # 0 = snap, >0 = smooth follow


func _ready() -> void:
	_target = get_tree().get_root().find_child("Player", true, false)
	self.make_current()


func _process(delta: float) -> void:
	if _target == null:
		return

	var desired: Vector2 = _target.global_position

	if use_bounds:
		desired.x = clamp(desired.x, bounds.position.x, bounds.position.x + bounds.size.x)
		desired.y = clamp(desired.y, bounds.position.y, bounds.position.y + bounds.size.y)

	if lerp_speed > 0.0:
		global_position = global_position.lerp(desired, 1.0 - exp(-lerp_speed * delta))
	else:
		global_position = desired