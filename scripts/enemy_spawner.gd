extends Node2D

var enemy_spawn_limit_x = 192
var enemy_spawn_limit_y = 440
@export var enemies: Array[PackedScene] = []


func _ready() -> void:
	print(position)
	spawn_enemy(get_random_index(), get_random_spawn_location())
	spawn_enemy(get_random_index(), get_random_spawn_location())
	spawn_enemy(get_random_index(), get_random_spawn_location())
	spawn_enemy(get_random_index(), get_random_spawn_location())
	spawn_enemy(get_random_index(), get_random_spawn_location())
	spawn_enemy(get_random_index(), get_random_spawn_location())
	spawn_enemy(get_random_index(), get_random_spawn_location())
	spawn_enemy(get_random_index(), get_random_spawn_location())
	spawn_enemy(get_random_index(), get_random_spawn_location())
	spawn_enemy(get_random_index(), get_random_spawn_location())


func spawn_enemy(index:int, spawn_position: Vector2):
	var enemies_node = get_node("../Enemies")
	if enemies_node == null:
		return
		
	if index < 0 or index >= enemies.size():
		return
	
	var enemy_scene = enemies[index]
	var spawned_enemy = enemy_scene.instantiate()
	
	enemies_node.add_child(spawned_enemy)
	
	if spawned_enemy is Node2D:
		spawned_enemy.position = spawn_position


func get_random_spawn_location():
	var random_position = position + Vector2(randf_range(-enemy_spawn_limit_x, enemy_spawn_limit_x), 
	randf_range(-enemy_spawn_limit_y, enemy_spawn_limit_y))
	return random_position


func get_random_index():
	var random = randi_range(0, enemies.size()-1)
	return random
