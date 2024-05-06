extends Area2D

var level = 1
var hp = 1
var speed = 100
var damage = 10
var knock_amount = 50
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

var sound_finished = false

@onready var player = get_tree().get_first_node_in_group("player")
@onready var mineSprite = $MineSprite
@onready var explode = $Explode
@onready var exploding = $AnimationPlayer
@onready var snd_explode = $AudioStreamPlayer

func _ready():
	mineSprite.visible = true
	explode.visible = false
	angle = global_position.normalized()
	rotation = angle.angle() + deg_to_rad(90)
	match level:
		1:
			hp = 1
			speed = 10
			damage = 10 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
		2:
			hp = 1
			speed = 10
			damage = 20 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
		3:
			hp = 1
			speed = 10
			damage = 30 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
		4:
			hp = 1
			speed = 10
			damage = 50 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
			
	scale = Vector2(1.0,1.0) * attack_size

func _physics_process(delta):
	position += angle*speed*delta

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		$CollisionShape2D.set_deferred("disabled", true)
		mineSprite.visible = false
		explode.visible = true
		exploding.play("exploding")
		snd_explode.play()
		if sound_finished == true:
			queue_free()

func _on_timer_timeout():
	queue_free()


func _on_audio_stream_player_finished():
	sound_finished = true


func _on_animation_player_animation_finished(_anim_name):
	explode.visible = false
