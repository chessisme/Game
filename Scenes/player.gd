extends Area2D

@export var speed = 400
var screen_size
var player_movement_vector
var player_movement_magnitude
var left_limit
var right_limit
signal hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size/2
	position.y = screen_size.y/1.25
	left_limit = Vector2(screen_size.x*.2, 0)
	right_limit = Vector2(screen_size.x*.8, screen_size.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_movement_vector = Input.get_vector("Move Left","Move Right","Move Forward","Move Backward")
	player_movement_magnitude = player_movement_vector.length()
	player_movement_magnitude = clamp(player_movement_magnitude , 0 ,1) 
	player_movement_vector = player_movement_vector.normalized()
	
	position += player_movement_vector * speed * player_movement_magnitude * delta
	position = position.clamp(left_limit, right_limit)

#setup for player getting hit
func _on_body_entered(body: Node2D) -> void:
	print("Hit")
	pass # Replace with function body.
