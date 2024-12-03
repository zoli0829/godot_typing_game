extends BaseBuilding

'''
timer needs to be one_shot
once we built the building we want to display the upgrade_command if we can upgrade
then we start the timer, once it finishes we wait for the user's input to call the produce_command
then we add the level to the resource
then we start the timer again

build() -> on_timer_out() -> we change the label -> GameManager.apple_farm.produce()
'''

@export var unit: CharacterBody2D

func _ready():
	super()
	#add_sprites_to_list() set_sprite_opacity_low() command_to_show = build_command update_label(command_to_show)
	add_commands_to_the_input_commands_list()


func build():
	super() # removes the build command from the InputManager's list
	
	for sprite in building_sprites:
		sprite.modulate.a = 1
	is_built = true
	
	command_to_show = upgrade_command
	update_label(command_to_show)
	upgrade()
	timer.start()
	GameManager.is_fletcher_built = true
	show_unit()


func upgrade():
	if is_fully_upgraded:
		# TODO: show a message on the screen that the building is fully upgraded
		return
	level += 1
	if level == max_level:
		is_fully_upgraded = true


func produce():
	super() # play fade out animation
	GameManager.bow += level
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


# this function will only be called when there is a unit like a blacksmith or wooddcutter
func show_unit():
	if unit == null:
		return
	unit.visible = true


func _on_timer_timeout():
	super() # play animation and print
	update_label(produce_commands[0])
