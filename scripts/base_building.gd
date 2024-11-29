extends Node2D

class_name BaseBuilding

@export var build_command: String
@export var upgrade_command: String
@export var produce_commands: Array[String]
@export var level: int = 0
@export var max_level: int 
@export var building_sprites: Array[Sprite2D]

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
	if InputManager.commands.has(build_command):
		InputManager.commands.erase(build_command)


func upgrade():
	pass


func produce():
	# generate lvl number of units every 60 seconds
	#GameManager.resource += level
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
	pass
