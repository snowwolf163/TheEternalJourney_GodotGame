extends CharacterBody2D

@export var mov_speed = 40
@export var hp = 10
@warning_ignore("shadowed_global_identifier")
@export var exp = 1
@export var enemy_damage = 1

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $Sprite2D
@onready var floating = $AnimationPlayer
@onready var hitbox = $hitbox

var exp_item = preload("res://scenes/Experience.tscn")

func _ready():
	floating.play("float")
	hitbox.damage = enemy_damage

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mov_speed
	move_and_slide()
	
	if direction.x > 0.1:
		sprite.flip_h = false
	elif direction.x < -0.1:
		sprite.flip_h = true
		

func death():
	var new_gem = exp_item.instantiate()
	new_gem.global_position = global_position
	new_gem.exp = exp
	loot_base.call_deferred("add_child", new_gem)
	queue_free()

func _on_hurtbox_hurt(damage):
	hp -= damage
	if hp <= 0:
		death()
