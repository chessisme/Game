extends Node2D

@export var PrimaryWeapon : PackedScene
@export var SecondaryWeapon : PackedScene 

var primary_cooldown = 0
var secondary_cooldown = 0

var new_projectile
var rootNode
func _ready() -> void:
	rootNode = get_node("/root")
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_pressed("Fire Main Weapon") and primary_cooldown <= 0):
		print("Fire Primary")
	if(Input.is_action_pressed("Fire Secondary Weapon") and secondary_cooldown <=0):
		print("Fire Secondary")
		new_projectile = SecondaryWeapon.instantiate();
		new_projectile.position = global_position
		rootNode.add_child(new_projectile)
		secondary_cooldown = new_projectile.cooldown
	
	if(primary_cooldown > 0):
		primary_cooldown-= delta
	if(secondary_cooldown > 0):
		secondary_cooldown -= delta
	
