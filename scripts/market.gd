extends BaseBuilding

var buy_or_sell_command: String = "buy or sell goods"


func _ready():
	super()
	add_commands_to_the_input_commands_list()


func build():
	# deletes the build command from the commands array
	super()
	
	for sprite in building_sprites:
		sprite.modulate.a = 1
	is_built = true
	command_to_show = buy_or_sell_command
	update_label(command_to_show)
	upgrade()
	# no need for timer
	GameManager.is_market_built = true


func upgrade():
	if is_fully_upgraded:
		# TODO: show a message on the screen that the building is fully upgraded
		print("Gets stuck in the IF statement then returns")
		return
	level += 1
	if level == max_level:
		is_fully_upgraded = true
		update_label("buy or sell goods")
		print("Updates the label!")


func produce():
	print("Now we can sell and buy goods!")


func add_commands_to_the_input_commands_list():
	InputManager.commands.append(build_command)
	InputManager.commands.append(upgrade_command)
	for command in produce_commands:
		InputManager.commands.append(command)


func update_label(text: String):
	label.text = text
