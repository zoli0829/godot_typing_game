extends Control

signal enemy_destroyed(enemy)
signal enemy_remove_request(enemy)

var typed_text = ""
var commands = [
"build market", "upgrade market",
"build inn", "upgrade_inn",
"build wall","upgrade wall",
]

@export var enemy_commands = []

var current_input = ""

@onready var text_edit: TextEdit = $TextEdit


func _ready():
	Engine.max_fps = 60


func _process(_delta):
	update_text_display()
	check_for_word_match()
	check_for_word_in_enemy_commands()


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
	return


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
		command_name = "on_" + command_name + "_typed"
		
		if GameManager.has_method(command_name):
			GameManager.call(command_name)
			clear_input()
		else:
			print("No matching,please make a function for function for: " + command_name)
			clear_input()


func remove_enemy_commmand_from_enemy_commmands_array(enemy_command: String):
	enemy_commands.erase(enemy_command)


func remove_command_from_commands(command):
	if commands.has(command):
		commands.erase(command)


func check_for_word_in_enemy_commands():
	if current_input in enemy_commands:
		for enemy in GameManager.get_enemies():
			if enemy.get_enemy_command() == current_input:
				emit_signal("enemy_destroyed", enemy)
				emit_signal("enemy_remove_request", enemy)
				GameManager.remove_enemy_from_enemies_array(enemy)
				remove_enemy_commmand_from_enemy_commmands_array(enemy.get_enemy_command())
				clear_input()
				break
