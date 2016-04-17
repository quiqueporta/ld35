extends KinematicBody2D

var color = ""

var gravity = 150.0
var velocity = Vector2()

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	velocity.y += delta * gravity

	var motion = velocity * delta
	move( motion )

func is_shape():
	return false