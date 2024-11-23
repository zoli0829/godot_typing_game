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
FUNCTIONS FOR BUILDINGS
'''
func build_market():
	if is_market_built:
		return
	print("Market built")
	is_market_built = true


func upgrade_market():
	print("Market upgraded")


func build_inn():
	if is_inn_built:
		return
	print("Inn built")
	is_inn_built = true


func upgrade_inn():
	print("Inn upgraded")


func build_iron_mine():
	if is_iron_mine_built:
		return
	print("Iron mine built")
	is_iron_mine_built = true


func upgrade_iron_mine():
	print("Iron mine upgraded")


func build_quarry():
	if is_quarry_built:
		return
	print("Quarry built")
	is_quarry_built = true


func upgrade_quarry():
	print("Quarry upgraded")


func build_wall():
	if is_wall_built:
		return
	print("Wall built")
	is_wall_built = true


func upgrade_wall():
	print("Walls upgraded")


func build_woodcutter_camp():
	if is_woodcutter_camp_built:
		return
	print("Woodcutter built")
	is_woodcutter_camp_built = true


func upgrade_woodcutter_camp():
	print("Woodcutter upgraded")


func build_apple_farm():
	if is_apple_farm_built:
		return
	print("Apple farm built")
	is_apple_farm_built = true


func upgrade_apple_farm():
	print("Apple farm upgraded")


func build_wheat_farm():
	if is_wheat_farm_built:
		return
	print("Wheat farm built")
	is_wheat_farm_built = true


func upgrade_wheat_farm():
	print("Wheat farm upgraded")
