extends Node

# Declare variables to manage typed text and list of words to check
var typed_text = ""
var target_words = ["trader", "tavern", "townhall"]
var current_input = ""
var current_target_index = -1  # -1 indicates no current target word

# Declare a TextEdit node to show the input text
@onready var text_edit = $TextEdit

func _process(delta):
	# Check if the player has typed anything, and update the display
	update_text_display()
	check_for_word_match()  # Check if the typed word matches any of the target words

# Capture key input using _input()
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_BACKSPACE or event.keycode == KEY_DELETE:
			remove_last_character()
		elif event.keycode == KEY_SPACE:
			add_space_to_input()  # Special handling for space
		else:
			add_character_to_input(event)

func remove_last_character():
	current_input = current_input.substr(0, current_input.length() - 1)

func add_space_to_input():
	current_input += " "  # Directly append a space

func add_character_to_input(event):
	var char = event.as_text()  # Get the character from the key event
	if char != "":
		current_input += char.to_lower()

func update_text_display():
	typed_text = ""
	var target_word = target_words[current_target_index] if current_target_index != -1 else ""
	var target_index = 0  # Track position within the target word
	var current_input_length = current_input.length()

	# Loop through the current input and color the text
	for i in range(current_input_length):
		var letter = current_input[i]
		if target_index < target_word.length() and letter == target_word[target_index]:
			# Correct character, highlight in green
			typed_text += letter
			target_index += 1  # Move to the next character in the target word
		else:
			# Incorrect character, highlight in white
			typed_text += letter

	# Add remaining target word characters in white if input is incomplete
	if target_index < target_word.length():
		typed_text += target_word.substr(target_index, target_word.length() - target_index)

	text_edit.text = typed_text

func check_for_word_match():
	if current_input in target_words:
		current_target_index = target_words.find(current_input)
		if current_target_index != -1:
			print("Success! You typed the word: " + target_words[current_target_index])
			
			# Reset everything after successful word match
			text_edit.text = typed_text  # Clear the TextEdit content
			current_input = ""  # Reset the input after success
			typed_text = ""  # Reset the typed text display
