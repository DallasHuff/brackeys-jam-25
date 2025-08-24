class_name Room
extends Node2D

@export var doors: Array[Door] # 0: top, 1: right, 2: bottom, 3: left
@export var main_walls: Array[StaticBody2D] # 0: top, 1: right, 2: bottom, 3: left
@export var camera: Camera2D # temporary, should follow player
@export var door_width: float = 1

func _ready() -> void:
	camera.make_current()

func initialize_doors(top_door: bool, right_door: bool, bottom_door: bool, left_door: bool) -> void:
	if top_door:
		main_walls[0].hide()
		_disable_wall_collision(main_walls[0])
	else:
		doors[0].hide()
	if right_door:
		main_walls[1].hide()
		_disable_wall_collision(main_walls[1])
	else:
		doors[1].hide()
	if bottom_door:
		main_walls[2].hide()
		_disable_wall_collision(main_walls[2])
	else:
		doors[2].hide()
	if left_door:
		main_walls[3].hide()
		_disable_wall_collision(main_walls[3])
	else:
		doors[3].hide()


func _disable_wall_collision(wall: StaticBody2D) -> void:
	for child: Node in wall.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", true)


func get_spawn_point(direction: Direction.Enum) -> Vector2:
	return doors[direction].spawnPoint.global_position


func enable_doors() -> void:
	for door: Door in doors:
		door.enabled = true
