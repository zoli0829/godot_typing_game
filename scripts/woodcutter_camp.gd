extends BaseBuilding


'''
Fill out the:
	build_command
	upgrade_command
	produce_command
Maybe add the timeout signal again if its not working
Hook up the functions in GameManager
Make functions for the produce commands
'''
func _ready():
	super()
	add_commands_to_the_input_commands_list()


func build():
	super()
	
	for sprite in building_sprites:
		sprite.modulate.a = 1
	is_built = true
	command_to_show = upgrade_command
	update_label(command_to_show)
	upgrade()
	timer.start(60)
	GameManager.is_woodcutter_camp_built = true


func upgrade():
	if is_fully_upgraded:
		# TODO: show a message on the screen that the building is fully upgraded
		return
	level += 1
	if level == max_level:
		is_fully_upgraded = true


func produce():
	GameManager.wood += level
	print("Now we have wood: ", GameManager.wood)


func add_commands_to_the_input_commands_list():
	InputManager.commands.append(build_command)
	InputManager.commands.append(upgrade_command)
	for command in produce_commands:
		InputManager.commands.append(command)


func update_label(text: String):
	label.text = text


func _on_timer_timeout():
	produce()
	timer.start()
