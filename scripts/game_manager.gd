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

var enemy_command_strings = ["charge", "attack", "fire", "destroy", "advance", "strike", "overwhelm", "seize them", "for glory", "no mercy"]
@export var enemies: Array[Node2D] = []


func _ready():
	# actually i dont know if this method is useful or not or if i need it 
	handle_resolution_and_scaling()
	InputManager.connect("enemy_destroyed", destroy_enemy)
	InputManager.connect("enemy_remove_request",remove_enemy_from_enemies_array)

'''
FUNCTIONS FOR BUILDINGS
'''
func on_build_market_typed():
	if is_market_built:
		return
	print("Market built")
	is_market_built = true


func on_upgrade_market_typed():
	print("Market upgraded")


func on_build_inn_typed():
	if is_inn_built:
		return
	print("Inn built")
	is_inn_built = true


func on_upgrade_inn_typed():
	print("Inn upgraded")


func on_build_iron_mine_typed():
	if is_iron_mine_built:
		return
	print("Iron mine built")
	is_iron_mine_built = true


func on_upgrade_iron_mine_typed():
	print("Iron mine upgraded")


func on_build_quarry_typed():
	if is_quarry_built:
		return
	print("Quarry built")
	is_quarry_built = true


func on_upgrade_quarry_typed():
	print("Quarry upgraded")


func on_build_wall_typed():
	if is_wall_built:
		return
	print("Wall built")
	is_wall_built = true


func on_upgrade_wall_typed():
	print("Walls upgraded")


func on_build_woodcutter_camp_typed():
	if is_woodcutter_camp_built:
		return
	print("Woodcutter built")
	is_woodcutter_camp_built = true


func on_upgrade_woodcutter_camp_typed():
	print("Woodcutter upgraded")


func on_build_apple_farm_typed():
	if is_apple_farm_built:
		return
	print("Apple farm built")
	is_apple_farm_built = true


func on_upgrade_apple_farm_typed():
	print("Apple farm upgraded")


func on_build_wheat_farm_typed():
	if is_wheat_farm_built:
		return
	print("Wheat farm built")
	is_wheat_farm_built = true


func on_upgrade_wheat_farm_typed():
	print("Wheat farm upgraded")


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
		# Set the base resolution
	var base_width = 1920
	var base_height = 1080

	# Get the current window size
	var current_size = DisplayServer.window_get_size()

	# Calculate the scale factor
	var scale_x = current_size.x / base_width
	var scale_y = current_size.y / base_height
	var scale_factor = min(scale_x, scale_y)  # Use the smaller scale to maintain aspect ratio

	# Apply scaling to the root viewport
	get_viewport().canvas_transform = Transform2D().scaled(Vector2(scale_factor, scale_factor))
