extends Node2D

var timer = null

var star = null

var star_blue = preload("res://shapes/star_blue.png")
var star_yellow = preload("res://shapes/star_yellow.png")
var star_violet = preload("res://shapes/star_violet.png")
var star_orange = preload("res://shapes/star_orange.png")
var star_green = preload("res://shapes/star_green.png")

var stars_created = 0
var stars_created_for_winner = 0

var colors = [config.BLUE, config.YELLOW]
var motivation_phrases = ["Wow!", "Great!", "Nice!", "Good!", "Come on!"]

var points = 0.0

var create_star = true

func _ready():
	set_fixed_process(true)

	star = load("res://shapes/estrella.scn")

	timer = get_node("Timer_estrella")
	timer.connect("timeout", self, "crear_estrella")
	
	update_score_label()

func _fixed_process(delta):
	pass
	
func crear_estrella():
	
	if create_star:
		stars_created += 1
		stars_created_for_winner += 1

		var new_star = star.instance()
		get_parent().add_child(new_star)
	
		new_star.set_pos(Vector2(200, get_pos().y))
	
		new_star.color = random_color()
	
		if new_star.color == config.BLUE:
			new_star.get_node("Sprite").set_texture(star_blue)
		elif new_star.color == config.YELLOW:
			new_star.get_node("Sprite").set_texture(star_yellow)
		elif new_star.color == config.VIOLET:
			new_star.get_node("Sprite").set_texture(star_violet)
		elif new_star.color == config.ORANGE:
			new_star.get_node("Sprite").set_texture(star_orange)
		elif new_star.color == config.GREEN:
			new_star.get_node("Sprite").set_texture(star_green)
		
		update_score_label()

	if stars_created == 25:
		colors.append(config.VIOLET)
		get_node("Circle").set_pos(Vector2(-200, -200))
		get_node("Triangle").set_pos(config.INITIAL_POSITION)

	if stars_created == 50:
		colors.append(config.ORANGE)
		get_node("Triangle").set_pos(Vector2(-200, -200))
		get_node("Square").set_pos(config.INITIAL_POSITION)

	if stars_created == 75:
		colors.append(config.GREEN)
		get_node("Square").set_pos(Vector2(-200, -200))
		get_node("Pentagon").set_pos(config.INITIAL_POSITION)
		
	if stars_created >= config.STARS_WINNER:
		create_star = false

func increase_points(increment=1):
	points += increment
	get_node("SamplePlayer").play("plop")
	create_motivation_phrase()
	update_score_label()
	
func check_if_winner():
	if points == config.STARS_WINNER:
		get_node("gui/Perfect").show()
	elif points < config.STARS_WINNER:
		get_node("gui/TryAgain").show()

func create_motivation_phrase():
	randomize()
	var value = randi()%5
	if value == 4:
		var motivation_phrase = motivation_phrases[(randi()%motivation_phrases.size())]
		get_node("gui/Motivator").set_text(motivation_phrase)
		get_node("gui/Motivator/AnimationPlayer").play("show_message")

func star_captured():
	stars_created_for_winner -= 1
	update_score_label()
	if stars_created_for_winner == 0 and stars_created == config.STARS_WINNER:
		check_if_winner()

func update_score_label():
	get_node("gui/Puntos").set_text(str(points)+"/"+str(stars_created))

func random_color():
	randomize()
	return colors[(randi()%colors.size())]