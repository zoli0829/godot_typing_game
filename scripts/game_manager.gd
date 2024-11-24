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

var enemy_command_strings = ["Charge!", "Attack!", "Fire!", "Destroy!", "Advance!", "Strike!", "Overwhelm!", "Seize them!", "For glory!", "No mercy!"]
@export var enemies: Array[Node2D] = []


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
