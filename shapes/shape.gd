var current_shape

var input_states = preload("res://shapes/input_states.gd")

var button_right = input_states.new("btn_right")
var button_left = input_states.new("btn_left")

var rotation_speed = 5.0

func _init(var shape):
	self.current_shape = shape

func add_collision(color):
	self.current_shape.get_node(color+"_area").connect("body_enter", self, "collision_"+color+"_area")

func button_left_pressed():
	return button_left.check() == 2

func button_right_pressed():
	return button_right.check() == 2
	
func collision(body, color):
	if body != self and !body.is_shape():
		self.current_shape.get_owner().star_captured()
		if body.color == color:
			self.current_shape.get_owner().increase_points()
			body.queue_free()
		else:
			body.queue_free()

func collision_blue_area( body ):
	collision(body, config.BLUE)

func collision_yellow_area( body ):
	collision(body, config.YELLOW)

func collision_violet_area( body ):
	collision(body, config.VIOLET)

func collision_orange_area( body ):
	collision(body, config.ORANGE)

func collision_green_area( body ):
	collision(body, config.GREEN)

func key_pressed(delta):
	if button_left_pressed():
		self.current_shape.set_rot(self.current_shape.get_rot() + rotation_speed * delta)
	elif button_right_pressed():
		self.current_shape.set_rot(self.current_shape.get_rot() - rotation_speed * delta)

func is_shape():
	return true