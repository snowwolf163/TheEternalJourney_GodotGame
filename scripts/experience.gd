extends Area2D

@warning_ignore("shadowed_global_identifier")
@export var exp = 1

var gem_blue = preload("res://Assets/Items/Gem_blue.png")
var gem_green = preload("res://Assets/Items/Gem_green.png")
var gem_red = preload("res://Assets/Items/Gem_red.png")

var target = null
var speed = -1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $snd_collect

func _ready():
	if exp < 5:
		return
	elif exp < 25:
		sprite.texture = gem_green
	else:
		sprite.texture = gem_red
	
func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2*delta

func collect():
	sound.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	return exp

func _on_snd_collect_finished():
	queue_free()
