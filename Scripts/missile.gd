extends RigidBody2D

@export var explosion :PackedScene
var animation_player

@export var impact_damage = 0;
@export var speed = 1000;

@export var tracking = false;
@export var tracking_rate = 0;

func _ready() -> void:
	animation_player = $AnimatedSprite2D
	animation_player.play()

func _process(delta: float) -> void:
	pass

func Detonate() -> void:
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = position
	queue_free()
