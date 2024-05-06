extends ColorRect

@onready var lblName = $lbl_name
@onready var lblDesc = $lbl_desc
@onready var lblLevel = $lbl_level
@onready var itemIcon = $ColorRect/ItemIcon

var mouse_over = false
var item = null
@onready var player = get_tree().get_first_node_in_group("player")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(player, "upgrade_character"))
	if item == null:
		item = "HPboost"
	lblName.text = UpgradeDb.UPGRADE[item]["displayname"]
	lblDesc.text = UpgradeDb.UPGRADE[item]["details"]
	lblLevel.text = UpgradeDb.UPGRADE[item]["level"]
	itemIcon.texture = load(UpgradeDb.UPGRADE[item]["icon"])

func _input(event):
	if event.is_action("Click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)

func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false
