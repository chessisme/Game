extends Area2D

@export var speed = 400
var screen_size
var player_movement_vector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	player_movement_vector = Input.get_vector("Move Left","Move Right","Move Forward","Move Backward")
	player_movement_vector = player_movement_vector.normalized()
	
	position += player_movement_vector * speed * delta
	position = position.clamp(Vector2.ZERO,screen_size)
	
	pass
