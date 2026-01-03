extends RigidBody2D

@export var explosion :PackedScene
var animation_player

@export var impact_damage = 0;
@export var speed = 2000;
@export var cooldown = 0.5;
@export var lifetime = 1;

@export var tracking = false;
@export var tracking_rate = 0;

func _ready() -> void:
	animation_player = $AnimatedSprite2D
	animation_player.play()
	

func _process(delta: float) -> void:
	position.y = position.y - speed * delta
	if(lifetime > 0):
		lifetime -= delta
	if(lifetime <= 0):
		queue_free()
	pass

func Detonate() -> void:
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = position
	queue_free()
