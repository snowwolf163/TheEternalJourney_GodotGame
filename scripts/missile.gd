extends Area2D

var level = 1
var hp = 1
var speed = 500
var damage = 10
var knock_amount = 50
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

var sound_finished = false

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(90)
	match level:
		1:
			hp = 1
			speed = 200
			damage = 10 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
		2:
			hp = 1
			speed = 200
			damage = 10 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
		3:
			hp = 2
			speed = 200
			damage = 20 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
		4:
			hp = 2
			speed = 200
			damage = 30 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
			
	scale = Vector2(1.0,1.0) * attack_size

func _physics_process(delta):
	position += angle*speed*delta

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.visible = false
		if sound_finished == true:
			queue_free()

func _on_timer_timeout():
	queue_free()


func _on_snd_play_finished():
	sound_finished = true
