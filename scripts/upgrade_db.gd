extends Node

const ICON_PATH = "res://Assets/Icons/Upgrades/Hex/"
const WEAPON_PATH = "res://Assets/Icons/Weapons/"
const UPGRADE = {
	"missile1":{
		"icon": WEAPON_PATH + "missile1.png",
		"displayname": "Missile",
		"details": "A missile is fired at a random enemy",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"missile2":{
		"icon": WEAPON_PATH + "missile1.png",
		"displayname": "Missile",
		"details": "An additional missile is fired at a random enemy",
		"level": "Level: 2",
		"prerequisite": ["missile1"],
		"type": "weapon"
	},
	"missile3":{
		"icon": WEAPON_PATH + "missile1.png",
		"displayname": "Missile",
		"details": "Missiles now pass through another enemy and do +10 damage",
		"level": "Level: 3",
		"prerequisite": ["missile2"],
		"type": "weapon"
	},
	"missile4":{
		"icon": WEAPON_PATH + "missile1.png",
		"displayname": "Missile",
		"details": "Missiles now do +10 damage",
		"level": "Level: 4",
		"prerequisite": ["missile3"],
		"type": "weapon"
	},
	"firebullet1":{
		"icon": WEAPON_PATH + "firebullet1.png",
		"displayname": "Fire Bullet",
		"details": "A fire bullet is fired from the ship",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"firebullet2":{
		"icon": WEAPON_PATH + "firebullet1.png",
		"displayname": "Fire Bullet",
		"details": "An additional fire bullet is fired from the ship",
		"level": "Level: 2",
		"prerequisite": ["firebullet1"],
		"type": "weapon"
	},
	"firebullet3":{
		"icon": WEAPON_PATH + "firebullet1.png",
		"displayname": "Fire Bullet",
		"details": "Fire bullets pass through another enemy and do +10 damage",
		"level": "Level: 3",
		"prerequisite": ["firebullet2"],
		"type": "weapon"
	},
	"firebullet4":{
		"icon": WEAPON_PATH + "firebullet1.png",
		"displayname": "Fire Bullet",
		"details": "Fire bullets do +20 damage",
		"level": "Level: 4",
		"prerequisite": ["firebullet3"],
		"type": "weapon"
	},
	"firebullet5":{
		"icon": WEAPON_PATH + "firebullet1.png",
		"displayname": "Fire Bullet",
		"details": "Fire bullets pass through another enemy and do +20 damage",
		"level": "Level: 5",
		"prerequisite": ["firebullet4"],
		"type": "weapon"
	},
	"iceBullet1":{
		"icon": WEAPON_PATH + "icebullet1.png",
		"displayname": "Ice Bullet",
		"details": "An ice bullet is fired from the ship",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"iceBullet2":{
		"icon": WEAPON_PATH + "icebullet1.png",
		"displayname": "Ice Bullet",
		"details": "An additional ice bullet is fired from the ship",
		"level": "Level: 2",
		"prerequisite": ["iceBullet1"],
		"type": "weapon"
	},
	"iceBullet3":{
		"icon": WEAPON_PATH + "icebullet1.png",
		"displayname": "Ice Bullet",
		"details": "Ice bullets pass through another enemy and do +10 damage",
		"level": "Level: 3",
		"prerequisite": ["iceBullet2"],
		"type": "weapon"
	},
	"iceBullet4":{
		"icon": WEAPON_PATH + "icebullet1.png",
		"displayname": "Ice Bullet",
		"details": "Ice bullets rotate faster and do +20 damage",
		"level": "Level: 4",
		"prerequisite": ["iceBullet3"],
		"type": "weapon"
	},
	"iceBullet5":{
		"icon": WEAPON_PATH + "icebullet1.png",
		"displayname": "Ice Bullet",
		"details": "Ice bullets get bigger and do +10 damage",
		"level": "Level: 5",
		"prerequisite": ["iceBullet4"],
		"type": "weapon"
	},
	"mine1":{
		"icon": WEAPON_PATH + "mine1.png",
		"displayname": "Mine",
		"details": "A mine is released",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"mine2":{
		"icon": WEAPON_PATH + "mine1.png",
		"displayname": "Mine",
		"details": "The mine does +10 damage and cooldown is reduced by 0.5 seconds",
		"level": "Level: 2",
		"prerequisite": ["mine1"],
		"type": "weapon"
	},
	"mine3":{
		"icon": WEAPON_PATH + "mine1.png",
		"displayname": "Mine",
		"details": "The mine does +10 damage and cooldown is reduced by 0.5 seconds",
		"level": "Level: 3",
		"prerequisite": ["mine2"],
		"type": "weapon"
	},
	"mine4":{
		"icon": WEAPON_PATH + "mine1.png",
		"displayname": "Mine",
		"details": "The mine does +20 damage",
		"level": "Level: 4",
		"prerequisite": ["mine3"],
		"type": "weapon"
	},
	"energyball1":{
		"icon": WEAPON_PATH + "energyball1.png",
		"displayname": "Energy Ball",
		"details": "An energy ball is released from the ship",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"energyball2":{
		"icon": WEAPON_PATH + "energyball1.png",
		"displayname": "Energy Ball",
		"details": "An additional energy ball is released from the ship",
		"level": "Level: 2",
		"prerequisite": ["energyball1"],
		"type": "weapon"
	},
	"energyball3":{
		"icon": WEAPON_PATH + "energyball1.png",
		"displayname": "Energy Ball",
		"details": "The energy ball cooldown is reduced by 0.5 seconds",
		"level": "Level: 3",
		"prerequisite": ["energyball2"],
		"type": "weapon"
	},
	"energyball4":{
		"icon": WEAPON_PATH + "energyball1.png",
		"displayname": "Energy Ball",
		"details": "The energy balls do +10 damage",
		"level": "Level: 4",
		"prerequisite": ["energyball3"],
		"type": "weapon"
	},
	"energyball5":{
		"icon": WEAPON_PATH + "energyball1.png",
		"displayname": "Energy Ball",
		"details": "The energy balls get bigger and do +10 damage",
		"level": "Level: 5",
		"prerequisite": ["energyball4"],
		"type": "weapon"
	},
	"armor1": {
		"icon": ICON_PATH + "slice25.png",
		"displayname": "Armor",
		"details": "Reduces Damage By 1 point",
		"level": "Level: 1",
		"prerequisite": ["mine1"],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ICON_PATH + "slice25.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ICON_PATH + "slice25.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ICON_PATH + "slice25.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	"speed1": {
		"icon": ICON_PATH + "slice30.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by 50% of base speed",
		"level": "Level: 1",
		"prerequisite": ["iceBullet1"],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "slice30.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "slice30.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "slice30.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased an additional 50% of base speed",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	"tome1": {
		"icon": ICON_PATH + "slice36.png",
		"displayname": "Bigger",
		"details": "Increases the size of attacks an additional 10% of their base size",
		"level": "Level: 1",
		"prerequisite": ["firebullet1"],
		"type": "upgrade"
	},
	"tome2": {
		"icon": ICON_PATH + "slice36.png",
		"displayname": "Bigger",
		"details": "Increases the size of attacks an additional 10% of their base size",
		"level": "Level: 2",
		"prerequisite": ["tome1"],
		"type": "upgrade"
	},
	"tome3": {
		"icon": ICON_PATH + "slice36.png",
		"displayname": "Bigger",
		"details": "Increases the size of attacks an additional 10% of their base size",
		"level": "Level: 3",
		"prerequisite": ["tome2"],
		"type": "upgrade"
	},
	"tome4": {
		"icon": ICON_PATH + "slice36.png",
		"displayname": "Bigger",
		"details": "Increases the size of attacks an additional 10% of their base size",
		"level": "Level: 4",
		"prerequisite": ["tome3"],
		"type": "upgrade"
	},
	"scroll1": {
		"icon": ICON_PATH + "slice28.png",
		"displayname": "Cooldown",
		"details": "Decreases of the cooldown of attacks by an additional 5% of their base time",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"scroll2": {
		"icon": ICON_PATH + "slice28.png",
		"displayname": "Cooldown",
		"details": "Decreases of the cooldown of attacks by an additional 5% of their base time",
		"level": "Level: 2",
		"prerequisite": ["scroll1"],
		"type": "upgrade"
	},
	"scroll3": {
		"icon": ICON_PATH + "slice28.png",
		"displayname": "Cooldown",
		"details": "Decreases of the cooldown of attacks by an additional 5% of their base time",
		"level": "Level: 3",
		"prerequisite": ["scroll2"],
		"type": "upgrade"
	},
	"scroll4": {
		"icon": ICON_PATH + "slice28.png",
		"displayname": "Cooldown",
		"details": "Decreases of the cooldown of attacks by an additional 5% of their base time",
		"level": "Level: 4",
		"prerequisite": ["scroll3"],
		"type": "upgrade"
	},
	"ring1": {
		"icon": ICON_PATH + "slice34.png",
		"displayname": "More Attack",
		"details": "Your attacks now spawn 1 more additional attack",
		"level": "Level: 1",
		"prerequisite": ["energyball1", "firebullet1", "icebullet1"],
		"type": "upgrade"
	},
	"ring2": {
		"icon": ICON_PATH + "slice34.png",
		"displayname": "More Attack",
		"details": "Your attacks now spawn an additional attack",
		"level": "Level: 2",
		"prerequisite": ["ring1"],
		"type": "upgrade"
	},
	"power1": {
		"icon": ICON_PATH + "slice33.png",
		"displayname": "Power",
		"details": "Your attacks now +10 damage",
		"level": "Level: 1",
		"prerequisite": ["missile2"],
		"type": "upgrade"
	},
	"power2": {
		"icon": ICON_PATH + "slice33.png",
		"displayname": "Power",
		"details": "Your attacks now +20 damage",
		"level": "Level: 2",
		"prerequisite": ["power1"],
		"type": "upgrade"
	},
	"HPboost":{
		"icon": ICON_PATH + "slice32.png",
		"displayname": "HP Booster",
		"details": "Heals for 20 health",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	},
	"Score":{
		"icon": ICON_PATH + "slice43.png",
		"displayname": "Score Booster",
		"details": "Increase 5000 score points",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	}
}
