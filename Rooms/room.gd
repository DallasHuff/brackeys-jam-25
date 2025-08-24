class_name Room
extends Node2D

@export var doors: Array[Door] # 0: top, 1: right, 2: bottom, 3: left
@export var camera: Camera2D # temporary, should follow player

func _ready() -> void:
	camera.make_current()

func initialize_doors(top_door: bool, right_door: bool, bottom_door: bool, left_door: bool) -> void:
	if !top_door:
		doors[0].hide()
	if !right_door:
		doors[1].hide()
	if !bottom_door:
		doors[2].hide()
	if !left_door:
		doors[3].hide()