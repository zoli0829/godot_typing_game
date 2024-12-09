extends Node2D

'''
SFX:
	play the build sfx in build()
	play the build sfx in upgrade()
	play the ready to harvest in on_timer_time_out()
	play the harvested sfx in process()
'''

class_name BaseBuilding

@export var build_command: String
@export var upgrade_command: String
@export var produce_commands: Array[String]
@export var level: int = 0
@export var max_level: int 
@export var building_sprites: Array[Sprite2D]
@export var resource_type: Enums.Resources
@export var unit: CharacterBody2D

var is_built = false
var is_fully_upgraded = false
var timer_seconds = 5

var command_to_show :String
@onready var label = $Label
@onready var timer = $Timer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var resource_icon: Node2D = $resource_icon
@onready var random_stream_player: AudioStreamPlayer2D = $RandomStreamPlayer2DComponent

# RESOURCES
@export var base_gold_requirement: int
@export var base_wood_requirement: int
@export var base_stone_requirement: int
@export var base_iron_requirement: int
@export var base_food_requirement: int
@export var base_bow_requirement: int
@export var base_weapon_requirement: int

@export var gold_requirement: int
@export var wood_requirement: int
@export var stone_requirement: int
@export var iron_requirement: int
@export var food_requirement: int
@export var bow_requirement: int
@export var weapon_requirement: int


func _ready():
	add_sprites_to_list()
	set_sprite_opacity_low()
	command_to_show = build_command
	update_label(command_to_show)
	add_commands_to_the_input_commands_list()
	
	# hide the progress bar then set it to visible in build()
	progress_bar.modulate.a = 0


func _process(delta: float) -> void:
	update_progress_bar()


# TODO: requirements need a design overhaul
func can_upgrade_or_build():
	return GameManager.iron >= iron_requirement and GameManager.stone >= stone_requirement and GameManager.wood >= wood_requirement and GameManager.food >= food_requirement and GameManager.gold >= gold_requirement and GameManager.bow >= bow_requirement and GameManager.weapon >= weapon_requirement 


func deduct_requirements():
	GameManager.iron -= iron_requirement
	GameManager.wood -= wood_requirement
	GameManager.stone -= stone_requirement
	GameManager.food -= food_requirement
	GameManager.gold -= gold_requirement
	GameManager.bow -= bow_requirement
	GameManager.weapon -= weapon_requirement
	
	GameManager.update_widget_labels()


func set_sprite_opacity_low():
	for sprite in building_sprites:
		sprite.modulate.a = 0.25


func build():
	if can_upgrade_or_build():
		deduct_requirements()
		InputManager.remove_command_from_commands(build_command)
		random_stream_player.play_random_build_sfx()
		
		for sprite in building_sprites:
			sprite.modulate.a = 1
		is_built = true
		progress_bar.modulate.a = 1
		
		command_to_show = upgrade_command
		update_label(command_to_show)
		upgrade()
		start_timer(timer_seconds)
		
		match self.name:
			"apple_farm":
				GameManager.is_apple_farm_built = true
			"blacksmith":
				GameManager.is_blacksmith_built = true
			"fletcher":
				GameManager.is_fletcher_built = true
			"inn":
				GameManager.is_inn_built = true
			"iron_mine":
				GameManager.is_iron_mine_built = true
			"market":
				GameManager.is_market_built = true
			"quarry":
				GameManager.is_quarry_built = true
			"wheat_farm":
				GameManager.is_wheat_farm_built = true
			"woodcutter_camp":
				GameManager.is_woodcutter_camp_built = true
			_:
				print("OH OH no boolean value was set to true in the is_xyz_built values!!!")
		
		if unit == null:
			return
		
		unit.visible = true


func upgrade():
	if is_fully_upgraded:
		#TODO: show a message on the screen that the building is fully upgraded
		InputManager.remove_command_from_commands(upgrade_command)
		return
	
	if can_upgrade_or_build():
		deduct_requirements()
		random_stream_player.play_random_build_sfx()
		
		level += 1
		if level == max_level:
			is_fully_upgraded = true


func produce():
	random_stream_player.play_random_harvested_sfx()
	resource_icon.play_fade_out_animation()
	
	match resource_type:
		Enums.Resources.NONE:
			return
		Enums.Resources.GOLD:
			GameManager.gold += level
		Enums.Resources.FOOD:
			GameManager.food += level
		Enums.Resources.WOOD:
			GameManager.wood += level
		Enums.Resources.STONE:
			GameManager.stone += level
		Enums.Resources.IRON:
			GameManager.iron += level
		Enums.Resources.BOW:
			GameManager.bow += level
		Enums.Resources.WEAPON:
			GameManager.weapon += level
		_:
			print("OH OH we need to increment some resource value!!!")
	start_timer(timer_seconds)
	
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


func add_sprites_to_list():
	var sprites_container = $sprites_container
	var sprites = sprites_container.get_children()
	for sprite in sprites:
		building_sprites.append(sprite)


func start_timer(seconds: int):
	timer.one_shot = true
	timer.start(seconds)


func update_progress_bar():
	if progress_bar == null:
		return
	
	progress_bar.max_value = timer_seconds
	progress_bar.step = 1
	progress_bar.show_percentage = false
	progress_bar.fill_mode = 3 # bottom to top
	progress_bar.set_value_no_signal(timer_seconds - timer.time_left)


func _on_timer_timeout() -> void:
	resource_icon.show_icon_and_play_ready_animation()
	random_stream_player.play_random_ready_to_harvest_sfx()
	update_label(produce_commands[0])
	print("Timer time out in: ", name)
