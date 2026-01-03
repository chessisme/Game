extends Area2D

@export var impact_damage = 0;
@export var speed = 1500;
@export var cooldown = 0.1;
@export var lifetime = 1;

@onready var rootNode = get_node("/root")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(delta)
	position.y -= speed * delta
	
	if(lifetime > 0):
		lifetime -= delta
	if(lifetime <= 0):
		queue_free()
