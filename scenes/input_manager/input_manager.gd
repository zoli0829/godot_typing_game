extends Node

var typed_text = ""
var commands = [
"build market", "upgrade market",
"build inn", "upgrade_inn",
"build iron mine", "upgrade iron mine",
"build quarry", "upgrade quarry",
"build wall","upgrade wall",
"build woodcutter camp", "upgrade woodcutter camp",
"build apple farm", "upgrade apple farm",
"build wheat farm", "upgrade wheat farm"
]
var current_input = ""

var text_edit: TextEdit


func _ready():
	Engine.max_fps = 60
	text_edit = $TextEdit


func _process(_delta):
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
		if GameManager.has_method(command_name):
			GameManager.call(command_name)
		else:
			print("No matching function for: " + command_name)
		
		# Reset everything after successful word match
		clear_input()
