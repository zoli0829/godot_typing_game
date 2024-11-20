extends Node

var typed_text = ""
var commands = [
"build market", "upgrade market",
"build inn", "upgrade_inn",
"build iron mine", "upgrade iron mine",
"build quarry", "upgrade quarry",
"build wall","upgrade wall",
"build woodcutter camp", "upgrade woodcutter camp"
]
var current_input = ""
#FLAGS
var is_market_built = false
var is_inn_built = false
var is_iron_mine_built = false
var is_quarry_built = false
var is_wall_built = false
var is_woodcutter_camp_built = false

@onready var text_edit = $TextEdit


func _ready():
	Engine.max_fps = 60


func _process(_delta):
	# Check if the player has typed anything, and update the display
	update_text_display()
	check_for_word_match()


# Capture key input using _input()
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_BACKSPACE or event.keycode == KEY_DELETE:
			remove_last_character()
		elif event.keycode == KEY_SPACE:
			add_space_to_input()
		elif event.keycode == KEY_ESCAPE:
			input_escape()
		elif event.keycode == KEY_ENTER:
			input_enter()
		else:
			add_character_to_input(event)


func remove_last_character():
	current_input = current_input.substr(0, current_input.length() - 1)


func add_space_to_input():
	current_input += " "


func input_escape():
	print("ESCAPE pressed")
	clear_input()


func input_enter():
	print("ENTER pressed")
	clear_input()


func add_character_to_input(event):
	var character = event.as_text()  # Get the character from the key event
	if character != "":
		current_input += character.to_lower()

func update_text_display():
	typed_text = current_input
	text_edit.text = typed_text


func clear_input():
	current_input = ""
	typed_text = ""
	text_edit.text = typed_text


func check_for_word_match():
	if current_input in commands:
		var command_name = current_input.replace(" ", "_")
		
		# Check if a function with the modified name exists and call it dynamically
		if has_method(command_name):
			call(command_name)
		else:
			print("No matching function for: " + command_name)
		
		# Reset everything after successful word match
		clear_input()

'''
FUNCTIONS FOR BUILDINGS
'''
func build_market():
	if is_market_built:
		return
	print("Market built")
	is_market_built = true


func upgrade_market():
	print("Market upgraded")


func build_inn():
	if is_inn_built:
		return
	print("Inn built")
	is_inn_built = true


func upgrade_inn():
	print("Inn upgraded")


func build_iron_mine():
	if is_iron_mine_built:
		return
	print("Iron mine built")
	is_iron_mine_built = true


func upgrade_iron_mine():
	print("Iron mine upgraded")


func build_quarry():
	if is_quarry_built:
		return
	print("Quarry built")
	is_quarry_built = true


func upgrade_quarry():
	print("Quarry upgraded")


func build_wall():
	if is_wall_built:
		return
	print("Wall built")
	is_wall_built = true


func upgrade_wall():
	print("Walls upgraded")


func build_woodcutter_camp():
	if is_woodcutter_camp_built:
		return
	print("Woodcutter built")
	is_woodcutter_camp_built = true


func upgrade_woodcutter_camp():
	print("Woodcutter upgraded")
