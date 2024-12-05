extends BaseBuilding

'''
THIS MARKET NEEDS SOME CUSTOM SCRIPTS TO MANAGER ALL THE DIFFERENT PRODUCE COMMANDS
'''
func _ready():
	super()
	# market does not need a visible progress bar
	progress_bar.visible = false


func build():
	super()
	# market does not need a visible progressbar
	progress_bar.visible = false



func upgrade():
	super()


func produce():
	super()


func add_commands_to_the_input_commands_list():
	super()


func update_label(text: String):
	super(text)
