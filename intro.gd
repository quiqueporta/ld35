
extends Node2D

var current_scene = null

var input_states = preload("res://shapes/input_states.gd")

var button_enter = input_states.new("btn_enter")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if button_enter_pressed():
		var scene = load("main.scn")
		var root = get_tree().get_root()
		var current_scene = get_tree().get_current_scene()
		current_scene.queue_free()
		var s = scene.instance()
		root.add_child(s)

func button_enter_pressed():
	return button_enter.check() == 2


