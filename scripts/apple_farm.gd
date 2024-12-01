extends BaseBuilding

'''
once we built the building we want to display the upgrade_command if we can upgrade
then we start the timer, once it finishes we wait for the user's input to call the produce_command
then we add the level to the resource
then we start the timer again
'''
func _ready():
	super()
	add_commands_to_the_input_commands_list()


func _process(delta: float) -> void:
	pass


func build():
	super() # removes the build command from the InputManager's list
	
	for sprite in building_sprites:
		sprite.modulate.a = 1
	is_built = true
	
	command_to_show = upgrade_command
	update_label(command_to_show)
	upgrade()
	timer.start(60)
	GameManager.is_apple_farm_built = true


func upgrade():
	if is_fully_upgraded:
		# TODO: show a message on the screen that the building is fully upgraded
		return
	level += 1
	if level == max_level:
		is_fully_upgraded = true
		


func produce():
	print("Waiting for harvest command...")
	command_to_show = produce_commands[0]
	update_label(command_to_show)


func producing():
	super()
	


func add_commands_to_the_input_commands_list():
	InputManager.commands.append(build_command)
	InputManager.commands.append(upgrade_command)
	for command in produce_commands:
		InputManager.commands.append(command)


func update_label(text: String):
	label.text = text


func _on_timer_timeout():
	produce()
