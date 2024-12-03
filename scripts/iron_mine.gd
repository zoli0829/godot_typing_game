extends BaseBuilding


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
	timer.start()
	GameManager.is_iron_mine_built = true


func upgrade():
	if is_fully_upgraded:
		# TODO: show a message on the screen that the building is fully upgraded
		return
	level += 1
	if level == max_level:
		is_fully_upgraded = true


func produce():
	super() # play fade out animation
	GameManager.iron += level
	timer.start()
	
	if is_fully_upgraded:
		command_to_show = ""
		update_label(command_to_show)
	else:
		command_to_show = upgrade_command
		update_label(command_to_show)


func add_commands_to_the_input_commands_list():
	InputManager.commands.append(build_command)
	InputManager.commands.append(upgrade_command)
	for command in produce_commands:
		InputManager.commands.append(command)


func update_label(text: String):
	label.text = text


func _on_timer_timeout():
	super()
	update_label(produce_commands[0])
