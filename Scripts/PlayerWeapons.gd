extends Area2D

@export var PrimaryWeapon : PackedScene

@export var SecondaryWeapon : PackedScene 

var primary_cooldown
var secondary_cooldown

var new_projectile
func _ready() -> void:
	
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_pressed("Fire Main Weapon")):
		pass
	if(Input.is_action_pressed("Fire Secondary Weapon")):
		new_projectile = SecondaryWeapon.instantiate();
		new_projectile.position = position + Vector2(0,-20)
		secondary_cooldown = new_projectile.cooldown
		pass
