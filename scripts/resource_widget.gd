extends Control

@onready var resource_sprite: TextureRect = $HBoxContainer/resource_sprite
@onready var resource_label: Label = $HBoxContainer/resource_label

@export var icon: Texture2D
@export var resource_type: Enums.Resources


func _ready():
	resource_sprite.texture = icon


func update_label():
	match resource_type:
		Enums.Resources.NONE:
			return
		Enums.Resources.GOLD:
			GameManager.gold_widget.resource_label.text = str(GameManager.gold)
		Enums.Resources.FOOD:
			GameManager.food_widget.resource_label.text = str(GameManager.food)
		Enums.Resources.WOOD:
			GameManager.wood_widget.resource_label.text = str(GameManager.wood)
		Enums.Resources.STONE:
			GameManager.stone_widget.resource_label.text = str(GameManager.stone)
		Enums.Resources.IRON:
			GameManager.iron_widget.resource_label.text = str(GameManager.iron)
		Enums.Resources.BOW:
			GameManager.bow_widget.resource_label.text = str(GameManager.bow)
		Enums.Resources.WEAPON:
			GameManager.weapon_widget.resource_label.text = str(GameManager.weapon)
		_:
			print("TYPE of Resource is not defined, check the enum or the GameManager!")
