extends Node2D

@export var texture: Texture2D

@onready var icon_sprite: Sprite2D = $icon_sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	icon_sprite.texture = texture
	self.visible = false


func show_icon_and_play_ready_animation():
	self.visible = true
	icon_sprite.modulate.a = 1
	animation_player.play("ready_to_gather")


func play_fade_out_animation():
	animation_player.play("fade_out")


func make_node_invisible():
	self.visible = false
