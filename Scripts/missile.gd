extends RigidBody2D

@export var explosion :PackedScene
var animation_player

@export var impact_damage = 0;
@export var speed = 500;
@export var cooldown = 0.5;
@export var lifetime = 1;

@export var tracking = false;
@export var tracking_rate = 0;

@onready var rootNode = get_node("/root")

func _ready() -> void:
	#animation_player = $AnimatedSprite2D
	#animation_player.play()
	linear_velocity =  Vector2(0, -speed)
	pass
	
func _process(delta: float) -> void:
	print(delta)
	#position.y -= speed * delta
	
	if(lifetime > 0):
		lifetime -= delta
	if(lifetime <= 0):
		Detonate()
	pass

func Detonate() -> void:
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = position
	rootNode.add_child(explosion_instance)
	queue_free()
