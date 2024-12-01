extends Node2D

'''
timer needs to be one_shot
once we built the building we want to display the upgrade_command if we can upgrade
then we start the timer, once it finishes we wait for the user's input to call the produce_command
then we add the level to the resource
then we start the timer again
'''
class_name BaseBuilding

@export var build_command: String
@export var upgrade_command: String
@export var produce_commands: Array[String]
@export var level: int = 0
@export var max_level: int 
@export var building_sprites: Array[Sprite2D]
@export var resource_type: Enums.Resources

var is_built = false
var is_fully_upgraded = false

var command_to_show :String
@onready var label = $Label
@onready var timer = $Timer


func _ready():
	add_sprites_to_list()
	set_sprite_opacity_low()
	command_to_show = build_command
	update_label(command_to_show)


func set_sprite_opacity_low():
	for sprite in building_sprites:
		sprite.modulate.a = 0.25


func build():
	# once we built the building, we erase that command from the list
	InputManager.remove_command_from_commands(build_command)
	# TODO: play SFX


func upgrade():
	# TODO:play SFX, and dont forget to call super() in the children
	pass


func produce():
	# TODO: play SFX, and dont forget to call super() in the children
	pass


func add_commands_to_the_input_commands_list():
	pass


func update_label(text: String):
	pass


func add_sprites_to_list():
	var sprites_container = $sprites_container
	var sprites = sprites_container.get_children()
	for sprite in sprites:
		building_sprites.append(sprite)


func _on_timer_timeout() -> void:
	print("Timer finished...")
