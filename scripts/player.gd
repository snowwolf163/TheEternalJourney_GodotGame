extends CharacterBody2D

@export var movement_speed = 50

var hp = 100
var maxhp = 100
var rotation_speed = 5
var jump_distance = 100
var jump_cooldown = 5
var direction : Vector2 = Vector2()
var player_angle : float
var last_movement = Vector2.UP
var time = 0
var score = 0

@warning_ignore("shadowed_global_identifier")
var exp = 0
var exp_level = 1
var collected_exp = 0

#Attacks
var missile = preload("res://scenes/Missile.tscn")
var energyBall = preload("res://scenes/EnergyBall.tscn")
var fireBullet = preload("res://scenes/FireBullet.tscn")
var iceBullet = preload("res://scenes/IceBullet.tscn")
var mine = preload("res://scenes/Mine.tscn")

@onready var missileTimer = get_node("%MissileTimer")
@onready var missileAttackTimer = get_node("%MissileAttackTimer")
@onready var energyBallTimer = get_node("%EnergyBallTimer")
@onready var energyBallAttackTimer = get_node("%EnergyBallAttackTimer")
@onready var fireBulletTimer = get_node("%FireBulletTimer")
@onready var fireBulletAttackTimer = get_node("%FireBulletAttackTimer")
@onready var iceBulletTimer = get_node("%IceBulletTimer")
@onready var iceBulletAttackTimer = get_node("%IceBulletAttackTimer")
@onready var mineTimer = get_node("%MineTimer")
@onready var mineAttackTimer = get_node("%MineAttackTimer")

#Missile
var missile_ammo = 0
var missile_baseammo = 0
var missile_attackspeed = 1.5
var missile_level = 1

#Energy Balll
var energyBall_ammo = 0
var energyBall_baseammo = 0
var energyBall_attackspeed = 3
var energyBall_level = 1

#Fire Bullet
var fireBullet_ammo = 0
var fireBullet_baseammo = 0
var fireBullet_attackspeed = 1.5
var fireBullet_level = 1

#Ice Bullet
var iceBullet_ammo = 0
var iceBullet_baseammo = 0
var iceBullet_attackspeed = 2
var iceBullet_level = 1

#Mine
var mine_ammo = 0
var mine_baseammo = 0
var mine_attackspeed = 3
var mine_level = 1

#Enemy
var enemy_close = []

@onready var head_of_ship = $HeadofShip
@onready var tail_of_ship = $TailofShip
@onready var sprite = $Sprite2D

#GUI
@onready var exp_bar = get_node("%ExpBar")
@onready var lbllevel = get_node("%lbl_level")
@onready var levelPanel = get_node("%LevelUp")
@onready var upgradeOption = get_node("%UpgradeOption")
@onready var itemOption = preload("res://scenes/item_option.tscn")
@onready var sndlvlup = get_node("%snd_levelup")
@onready var healthBar = get_node("%HealthBar")
@onready var lblTimer = get_node("%lblTimer")
@onready var collectedWeapons = get_node("%CollectedWeapons")
@onready var collectedUpgrades = get_node("%CollectedUpgrades")
@onready var itemContainer = preload("res://scenes/ItemContainer.tscn")
@onready var instruction = get_node("%HowToPlay")
@onready var lblScore = get_node("%Score")
@onready var lblRating = get_node("%Rating")

@onready var deathPanel = get_node("%DeathPanel")
@onready var lblResult = get_node("%lbl_result")
@onready var sndVictory = get_node("%snd_victory")
@onready var sndLose = get_node("%snd_lose")

#UPGRADE
var collected_upgrades = []
var upgrade_options = []
var armor = 0
var speed = 0
var attack_cooldown = 0
var attack_size = 0
var attack_damage = 0
var additional_attack = 0

#Signal
signal playerdeath

func _ready():
	upgrade_character("missile1")
	levelPanel.visible = false
	deathPanel.visible = false
	set_expbar(exp, calculate_experience_cap())
	_on_hurtbox_hurt(0)

func movement(delta):
#	var input = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
	if Input.is_action_pressed("down"):
		velocity.y += 1
		direction = Vector2(0, 1)
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2 (1, 0)
		
	if Input.is_action_pressed("jump"):
		movement_speed  = 200 + speed
	else: movement_speed = 50 + speed
	
	if Input.is_action_pressed("stop"):
		movement_speed = 0
	
	velocity = velocity.normalized()*movement_speed
#	rotation = lerp_angle(rotation, rotation + deg_to_rad(input.x), delta)
	player_angle = Vector2.UP.angle_to(velocity)
	if velocity.length()>0:
		last_movement = Vector2(Input.get_action_strength("right")-Input.get_action_strength("left"), Input.get_action_strength("down")-Input.get_action_strength("up"))
		rotation = lerp_angle(rotation, player_angle, delta*rotation_speed)
	move_and_slide()

func attack():
	if missile_level > 0:
		missileTimer.wait_time = missile_attackspeed * (1-attack_cooldown)
		if missileTimer.is_stopped():
			missileTimer.start()
	if energyBall_level > 0:
		energyBallTimer.wait_time = energyBall_attackspeed * (1-attack_cooldown)
		if energyBallTimer.is_stopped():
			energyBallTimer.start()
	if fireBullet_level > 0:
		fireBulletTimer.wait_time = fireBullet_attackspeed * (1-attack_cooldown)
		if fireBulletTimer.is_stopped():
			fireBulletTimer.start()
	if iceBullet_level > 0:
		iceBulletTimer.wait_time = iceBullet_attackspeed * (1-attack_cooldown)
		if iceBulletTimer.is_stopped():
			iceBulletTimer.start()
	if mine_level > 0:
		mineTimer.wait_time = mine_attackspeed * (1-attack_cooldown)
		if mineTimer.is_stopped():
			mineTimer.start()

func _process(delta):
	movement(delta)
	if lblTimer.text == "00:30":
		instruction.visible = false


func _on_hurtbox_hurt(damage):
	hp -= clamp(damage-armor, 1.0, 999.0)
	healthBar.max_value = maxhp
	healthBar.value = hp
	if hp <= 0:
		death()

func death():
	score = score * 10
	lblScore.text = str(score)
	if score <= 10000:
		lblRating.text = str("Bad")
	elif score <= 30000:
		lblRating.text = str("Meh")
	elif score <= 50000:
		lblRating.text = str("Average")
	elif score <= 70000:
		lblRating.text = str("Alright")
	elif score <= 100000:
		lblRating.text = str("Nice")
	elif score <= 150000:
		lblRating.text = str("Good")
	elif score <= 200000:
		lblRating.text = str("Excellent")
	else:
		lblRating.text = str("Pro Gamer")
	deathPanel.visible = true
	emit_signal("playerdeath")
	get_tree().paused = true
	var tween = deathPanel.create_tween()
	tween.tween_property(deathPanel,"position",Vector2(475,200),3.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	if time >= 300:
		lblResult.text = "YOU WIN!"
		sndVictory.play()
	else:
		lblResult.text = "YOU LOSE!"
		sndLose.play()

func _on_missile_timer_timeout():
	missile_ammo += missile_baseammo + additional_attack
	missileAttackTimer.start()

func _on_missile_attack_timer_timeout():
	if missile_ammo > 0:
		var missile_attack = missile.instantiate()
		missile_attack.position = position
		missile_attack.target = _get_closest_target()
		missile_attack.level = missile_level
		add_child(missile_attack)
		missile_ammo -= 1
		if missile_ammo > 0:
			missileAttackTimer.start()
		else:
			missileAttackTimer.stop()

func _on_energy_ball_timer_timeout():
	energyBall_ammo += energyBall_baseammo + additional_attack
	energyBallAttackTimer.start()

func _on_energy_ball_attack_timer_timeout():
	if energyBall_ammo > 0:
		var energyBall_attack = energyBall.instantiate()
		energyBall_attack.position = position
		energyBall_attack.last_movement = last_movement
		energyBall_attack.level = energyBall_level
		add_child(energyBall_attack)
		energyBall_ammo -= 1
		if energyBall_ammo > 0:
			energyBallAttackTimer.start()
		else:
			energyBallAttackTimer.stop()

func _on_fire_bullet_timer_timeout():
	fireBullet_ammo += fireBullet_baseammo + additional_attack
	fireBulletAttackTimer.start()

func _on_fire_bullet_attack_timer_timeout():
	if fireBullet_ammo > 0:
		var fireBullet_attack = fireBullet.instantiate()
		fireBullet_attack.position = head_of_ship.global_position
		fireBullet_attack.angle = direction.normalized()
		fireBullet_attack.level = fireBullet_level
		add_child(fireBullet_attack)
		fireBullet_ammo -= 1
		if fireBullet_ammo > 0:
			fireBulletAttackTimer.start()
		else:
			fireBulletAttackTimer.stop()
			
func _on_ice_bullet_timer_timeout():
	iceBullet_ammo += iceBullet_baseammo + additional_attack
	iceBulletAttackTimer.start()

func _on_ice_bullet_attack_timer_timeout():
	if iceBullet_ammo > 0:
		var iceBullet_attack = iceBullet.instantiate()
		iceBullet_attack.position = head_of_ship.global_position
		iceBullet_attack.target = _get_closest_target()
		iceBullet_attack.level = iceBullet_level
		add_child(iceBullet_attack)
		iceBullet_ammo -= 1
		if iceBullet_ammo > 0:
			iceBulletAttackTimer.start()
		else:
			iceBulletAttackTimer.stop()

func _on_mine_timer_timeout():
	mine_ammo += mine_baseammo + additional_attack
	mineAttackTimer.start()


func _on_mine_attack_timer_timeout():
	if mine_ammo > 0:
		var mine_attack = mine.instantiate()
		mine_attack.position = tail_of_ship.global_position
		mine_attack.target = _get_closest_target()
		mine_attack.level = mine_level
		add_child(mine_attack)
		mine_ammo -= 1
		if mine_ammo > 0:
			mineAttackTimer.start()
		else:
			mineAttackTimer.stop()


func _get_closest_target() -> Vector2:
	if enemy_close.size() == 0:
		return Vector2.UP
	var closest_distance = INF
	var closest_enemy
	for enemy in enemy_close:
		var distance = (global_position - enemy.global_position).length()
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	return closest_enemy.global_position


func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)


func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var item_exp = area.collect()
		calculate_experience(item_exp)


func calculate_experience(item_exp):
	var exp_required = calculate_experience_cap()
	collected_exp += item_exp
	score += item_exp
	if exp + collected_exp >= exp_required:
		collected_exp -= exp_required-exp
		exp_level += 1
		exp = 0
		exp_required = calculate_experience_cap()
		levelup()
	else:
		exp += collected_exp
		collected_exp = 0
		
	set_expbar(exp, exp_required)

func calculate_experience_cap():
	var exp_cap = exp_level
	if exp_level < 25:
		exp_cap = exp_level*5
	elif exp_level < 40:
		@warning_ignore("standalone_expression")
		exp_cap + 95 * (exp_level-19)*8
	elif exp_level < 60:
		@warning_ignore("standalone_expression")
		exp_cap + 180 * (exp_level-29)*10
	else:
		exp_cap = 255 * (exp_level-39)*12
	return exp_cap

func set_expbar(set_value = 1, set_max_value = 100):
	exp_bar.value = set_value
	exp_bar.max_value = set_max_value

func levelup():
	sndlvlup.play()
	lbllevel.text = str("   Level: ", exp_level)
	var tween = levelPanel.create_tween()
	tween.tween_property(levelPanel,"scale",Vector2(1,1)*2,0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	levelPanel.visible = true
	var options = 0
	var options_max = 3
	while options < options_max:
		var option_choice = itemOption.instantiate()
		option_choice.item = get_random_item()
		upgradeOption.add_child(option_choice)
		options += 1
	get_tree().paused = true

func upgrade_character(upgrade):
	match upgrade:
		"missile1":
			missile_level = 1
			missile_baseammo += 1
		"missile2":
			missile_level = 2
			missile_baseammo += 1
		"missile3":
			missile_level = 3
		"missile4":
			missile_level = 4
		"firebullet1":
			fireBullet_level = 1
			fireBullet_baseammo += 1
		"firebullet2":
			fireBullet_level = 2
			fireBullet_baseammo += 1
		"firebullet3":
			fireBullet_level = 3
		"firebullet4":
			fireBullet_level = 4
		"firebullet5":
			fireBullet_level = 5
		"iceBullet1":
			iceBullet_level = 1
			iceBullet_baseammo += 1
		"iceBullet2":
			iceBullet_level = 2
			iceBullet_baseammo += 1
		"iceBullet3":
			iceBullet_level = 3
			iceBullet_attackspeed -= 0.5
		"iceBullet4":
			iceBullet_level = 4
		"iceBullet5":
			iceBullet_level = 5
		"mine1":
			mine_level = 1
			mine_baseammo += 1
		"mine2":
			mine_level = 2
			mine_attackspeed -= 0.5
		"mine3":
			mine_level = 3
			mine_attackspeed -= 0.5
		"mine4":
			mine_level = 4
		"energyball1":
			energyBall_level = 1
			energyBall_baseammo += 1
		"energyball2":
			energyBall_level = 2
			energyBall_baseammo += 1
		"energyball3":
			energyBall_level = 3
			energyBall_attackspeed -= 0.5
		"energyball4":
			energyBall_level = 4
		"energyball5":
			energyBall_level = 5
		"armor1","armor2","armor3","armor4":
			armor += 1
		"speed1","speed2","speed3","speed4":
			movement_speed += 20.0
		"tome1","tome2","tome3","tome4":
			attack_size += 0.10
		"scroll1","scroll2","scroll3","scroll4":
			attack_cooldown += 0.05
		"ring1","ring2":
			additional_attack += 1
		"power1":
			attack_damage += 10
		"power2":
			attack_damage += 20
		"HPboost":
			hp += 20
			hp = clamp(hp,0,maxhp)
		"Score":
			score += 5000
	adjust_gui_collection(upgrade)
	attack()
	var option_children = upgradeOption.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	levelPanel.visible = false
	levelPanel.scale = Vector2(0.1,0.1)
	get_tree().paused = false
	calculate_experience(0)

func get_random_item():
	var dblist = []
	for i in UpgradeDb.UPGRADE:
		if i in collected_upgrades:
			pass
		elif i in upgrade_options:
			pass
		elif UpgradeDb.UPGRADE[i]["type"] == "item":
			pass
		elif UpgradeDb.UPGRADE[i]["prerequisite"].size()>0:
			var to_add = true
			for n in UpgradeDb.UPGRADE[i]["prerequisite"]:
				if not n in collected_upgrades:
					to_add = false
			if to_add:
				dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size()>0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null

func change_time(argtime = 0):
	time = argtime
	score += argtime
	var get_m = int(time/60.0)
	var get_s = time%60
	if get_m < 10:
		get_m = str(0,get_m)
	if get_s < 10:
		get_s = str(0,get_s)
	lblTimer.text = str(get_m, ":", get_s)

func adjust_gui_collection(upgrade):
	var get_upgraded_displayname = UpgradeDb.UPGRADE[upgrade]["displayname"]
	var get_type = UpgradeDb.UPGRADE[upgrade]["type"]
	if get_type != "item":
		var get_collected_displaynames = []
		for i in collected_upgrades:
			get_collected_displaynames.append(UpgradeDb.UPGRADE[i]["displayname"])
		if not get_upgraded_displayname in get_collected_displaynames:
			var new_item = itemContainer.instantiate()
			new_item.upgrade = upgrade
			match get_type:
				"weapon":
					collectedWeapons.add_child(new_item)
				"upgrade":
					collectedUpgrades.add_child(new_item)

func _on_button_menu_click_end():
	get_tree().paused = false
	var _menu = get_tree().change_scene_to_file("res://scenes/Menu.tscn")
