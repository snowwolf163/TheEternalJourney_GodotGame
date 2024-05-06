extends Area2D

@onready var engine_sprite = $Sprite2D
@onready var jumpTimer = get_node("jumpTimer")
@onready var anim = $AnimationPlayer

func _ready():
	engine_sprite.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("jump"):
		engine_sprite.show()
		anim.play("jump")
	else:
		engine_sprite.hide()
		anim.stop()
