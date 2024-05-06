extends Area2D

var level = 1
var hp = 1
var speed = 100
var damage = 10
var knock_amount = 50
var attack_size = 1.0

var start_radius = 10  # Start with a small radius to simulate firing from the player's center
var max_radius = 150  # The maximum radius the bullet will reach to orbit around the player
var radius = start_radius  # Current radius, which will increase from start_radius to max_radius
var orbit_speed = 2  # Speed of orbiting around the player
var current_angle = 0  # Current angle of rotation around the player
var expanding_speed = 100  # Speed at which the bullet moves from the player to the orbit path

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	rotation = angle.angle() + deg_to_rad(90)
	match level:
		1:
			hp = 1
			speed = 500
			orbit_speed = 2
			damage = 10 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
		2:
			hp = 1
			speed = 500
			orbit_speed = 2
			damage = 10 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
		3:
			hp = 2
			speed = 500
			orbit_speed = 2
			damage = 20 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
		4:
			hp = 2
			speed = 500
			orbit_speed = 3
			damage = 40 + player.attack_damage
			knock_amount = 50
			attack_size = 1.0 * (1+player.attack_size)
		5:
			hp = 3
			speed = 500
			orbit_speed = 3
			damage = 50 + player.attack_damage
			knock_amount = 50
			attack_size = 1.2 * (1+player.attack_size)
			
	scale = Vector2(1.0,1.0) * attack_size
	# Initial position set to start orbiting around the player
	position = player.position + Vector2(radius, 0)

func _physics_process(delta):
	# Increase the radius to simulate the bullet moving out to its orbit
	if radius < max_radius:
		radius += expanding_speed * delta
		if radius > max_radius:
			radius = max_radius

	current_angle -= orbit_speed * delta
	var x = radius * cos(current_angle)
	var y = radius * sin(current_angle)
	position = player.position + Vector2(x, y)
	# Optional: Rotate the bullet to face its moving direction
	rotation = current_angle

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.visible = false
		queue_free()

func _on_timer_timeout():
	queue_free()
