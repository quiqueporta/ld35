extends KinematicBody2D

var base_shape = preload("res://shapes/shape.gd")
var shape = base_shape.new(get_node("."))

func _ready():
	set_fixed_process(true)

	shape.add_collision(config.BLUE)
	shape.add_collision(config.YELLOW)
	shape.add_collision(config.VIOLET)
	
func _fixed_process(delta):
	shape.key_pressed(delta)

func is_shape():
	return shape.is_shape()
