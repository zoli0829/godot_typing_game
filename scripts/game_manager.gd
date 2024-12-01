extends Node

#FLAGS
var is_market_built = false
var is_inn_built = false
var is_iron_mine_built = false
var is_quarry_built = false
var is_wall_built = false
var is_woodcutter_camp_built = false
var is_apple_farm_built = false
var is_wheat_farm_built = false

'''
CACHED BUILDINGS
'''
var apple_farm: BaseBuilding
var inn: BaseBuilding
var iron_mine: BaseBuilding
var market: BaseBuilding
var quarry: BaseBuilding
var wheat_farm: BaseBuilding
var woodcutter_camp: BaseBuilding

'''
CACHED WIDGETS
'''
var gold_widget: Control
var food_widget: Control
var wood_widget: Control
var iron_widget: Control
var stone_widget: Control
var bow_widget: Control
var weapon_widget: Control

'''
RESOURCES
'''
var bow: int = 0
var weapon: int = 0
var food: int = 0
var gold: int = 0
var iron: int = 0
var stone: int = 0
var wood: int = 0

var enemy_command_strings = ["charge", "attack", "fire", "destroy", "advance", "strike", "overwhelm", "seize them", "for glory", "no mercy"]
@export var enemies: Array[Node2D] = []


func _ready():
	# actually i dont know if this method is useful or not or if i need it 
	handle_resolution_and_scaling()
	# TODO if scene is game scene and not main menu scene
	find_buildings()
	find_widgets()
	
	InputManager.connect("enemy_destroyed", destroy_enemy)
	InputManager.connect("enemy_remove_request",remove_enemy_from_enemies_array)

'''
FUNCTIONS FOR BUILDINGS
'''
# MARKET FUNCTIONS
func on_build_market_typed():
	if is_market_built:
		return
		
	market.build()
	is_market_built = true


func on_upgrade_market_typed():
	market.upgrade()


func on_buy_wood_typed():
	wood += 1


func on_buy_stone_typed():
	stone += 1


func on_buy_food_typed():
	food += 1


func on_buy_iron_typed():
	iron += 1


func on_sell_wood_typed():
	wood -= 1


func on_sell_stone_typed():
	stone -= 1


func on_sell_food_typed():
	food -= 1


func on_sell_iron_typed():
	iron -= 1


# INN FUNCTIONS
func on_build_inn_typed():
	if is_inn_built:
		return
		
	inn.build()
	is_inn_built = true


func on_upgrade_inn_typed():
	inn.upgrade()


func on_collect_gold_typed():
	gold += inn.level


# IRON MINE FUNCTIONS
func on_build_iron_mine_typed():
	if is_iron_mine_built:
		return
		
	iron_mine.build()
	is_iron_mine_built = true


func on_upgrade_iron_mine_typed():
	iron_mine.upgrade()


func on_collect_iron_typed():
	iron += iron_mine.level


# QUARRY FUNCTIONS
func on_build_quarry_typed():
	if is_quarry_built:
		return
		
	quarry.build()
	is_quarry_built = true


func on_upgrade_quarry_typed():
	quarry.upgrade()


func on_collect_stones_typed():
	stone += quarry.level


# WALL FUNCTIONS
func on_build_wall_typed():
	if is_wall_built:
		return
		
	print("Wall built")
	is_wall_built = true


func on_upgrade_wall_typed():
	print("Walls upgraded")


# WOODCUTTER CAMP FUNCTIONS
func on_build_woodcutter_camp_typed():
	if is_woodcutter_camp_built:
		return
		
	woodcutter_camp.build()
	is_woodcutter_camp_built = true


func on_upgrade_woodcutter_camp_typed():
	woodcutter_camp.upgrade()


func on_collect_wood_typed():
	wood += woodcutter_camp.level


# APPLE FARM FUNCTIONS
func on_build_apple_farm_typed():
	if is_apple_farm_built:
		return
	
	apple_farm.build()
	is_apple_farm_built = true


func on_upgrade_apple_farm_typed():
	apple_farm.upgrade()


func on_harvest_apples_typed():
	food += apple_farm.level


# WHEAT FARM FUNCTIONS
func on_build_wheat_farm_typed():
	if is_wheat_farm_built:
		return
		
	wheat_farm.build()
	is_wheat_farm_built = true


func on_upgrade_wheat_farm_typed():
	wheat_farm.upgrade()


func on_harvest_wheat_typed():
	food += wheat_farm.level


func find_buildings():
	var root = get_tree().root
	var game_scene = root.get_node("game")
	var buildings_node = game_scene.get_node("Buildings")
	
	apple_farm = buildings_node.get_node("apple_farm")
	inn = buildings_node.get_node("inn")
	iron_mine = buildings_node.get_node("iron_mine")
	market = buildings_node.get_node("market")
	quarry = buildings_node.get_node("quarry")
	wheat_farm = buildings_node.get_node("wheat_farm")
	woodcutter_camp = buildings_node.get_node("woodcutter_camp")


func find_widgets():
	var root = get_tree().root
	var game_scene2 = root.get_node("game")
	var game_ui = game_scene2.get_node("GameUi")
	var panel_container = game_ui.get_node("PanelContainer")
	var margin_container = panel_container.get_node("MarginContainer")
	var hbox_container = margin_container.get_node("HBoxContainer")
	
	gold_widget = hbox_container.get_node("Gold")
	food_widget = hbox_container.get_node("Food")
	wood_widget = hbox_container.get_node("Wood")
	iron_widget = hbox_container.get_node("Iron")
	stone_widget = hbox_container.get_node("Stone")
	bow_widget = hbox_container.get_node("Bow")
	weapon_widget = hbox_container.get_node("Weapon")


'''
Destroy Enemy Function
'''
func destroy_enemy(enemy: Node2D):
	enemy.kill_enemy()


'''
Remove Enemy From enemies[]
'''
func remove_enemy_from_enemies_array(enemy: Node2D):
	if enemies.has(enemy):
		enemies.erase(enemy)
		print("enemy got erased from the array: ", enemy)
	else:
		print("Enemy not found in the array!")


'''
Getter functions
'''
func get_enemies():
	return enemies

'''
System or Settings functions
'''

func handle_resolution_and_scaling():
	var base_width = 1920
	var base_height = 1080

	var current_size = DisplayServer.window_get_size()

	# Calculate the scale factor
	var scale_x = current_size.x / base_width
	var scale_y = current_size.y / base_height
	var scale_factor = min(scale_x, scale_y)  # Use the smaller scale to maintain aspect ratio

	# Apply scaling to the root viewport
	get_viewport().canvas_transform = Transform2D().scaled(Vector2(scale_factor, scale_factor))
