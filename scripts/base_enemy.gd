extends Node2D

@export var enemy_command : String  # Random word for the enemy
@export var label: Label

func _ready() -> void:
	pick_random_word_and_append_to_enemy_commands()
	add_enemy_to_game_manager()


func pick_random_word_and_append_to_enemy_commands():
	# Filter out commands that are already in the list
	var available_commands = GameManager.enemy_command_strings.filter(
		func(command): return not InputManager.enemy_commands.has(command)
	)
	
	if available_commands.size() > 0:
		enemy_command = available_commands.pick_random().to_lower()
		InputManager.enemy_commands.append(enemy_command)
		print(enemy_command + " was added to the commands")
		update_label(enemy_command)
	else:
		print("No more unique commands available!")


func add_enemy_to_game_manager():
	GameManager.enemies.append(self)


func update_label(_text):
	if label == null:
		return
	label.text = _text


func get_enemy_command():
	return enemy_command


func kill_enemy():
	# play death animation
	# we will queue free from anim, so the anim can play
	# play sfx
	# but for now:
	print("Unit destroyed!")
	queue_free()
	pass
