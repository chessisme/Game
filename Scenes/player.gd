extends Area2D

@export var normal_speed = 400
@export var dodge_speed = 550
@export var boost_speed = 1000

var curent_speed = 400
@export var animation_player :AnimatedSprite2D
var animation_state = "normal"

var screen_size
var player_movement_vector
var player_movement_magnitude
var left_limit
var right_limit
signal hit


func _ready() -> void:

	
	screen_size = get_viewport_rect().size
	position = screen_size/2
	position.y = screen_size.y/1.25
	left_limit = Vector2(screen_size.x*.2, 0)
	right_limit = Vector2(screen_size.x*.8, screen_size.y)


func _process(delta: float) -> void:
	#Process input for player movement
	player_movement_vector = Input.get_vector("Move Left","Move Right","Move Forward","Move Backward")
	player_movement_magnitude = player_movement_vector.length()
	player_movement_magnitude = clamp(player_movement_magnitude , 0 ,1) 
	player_movement_vector = player_movement_vector.normalized()
	
	#Dodge input
	if (Input.is_action_pressed("Dodge")):
		animation_state = "dodge"
		if(player_movement_vector.x < 0):
			animation_player.flip_h = true
		if(abs(player_movement_vector.x) > 0.5):
			animation_player.set_frame(4)
		animation_player.play("Flip")
	
	#Animate the ship side to side
	if(animation_state == "normal"):
		if(player_movement_vector.x > 0.5):
			animation_player.animation = "Right"
		elif (player_movement_vector.x < -0.5):
			animation_player.animation = "Left"
		else:
			animation_player.animation = "Centered"
	
	#set speed fort curent situation
	if(animation_state == "dodge"):
		curent_speed = dodge_speed
	elif (animation_state == "boost"):
		curent_speed = boost_speed
	else:
		curent_speed = normal_speed
		
	#Move the player and clamp them to the bounds of the play area
	position += player_movement_vector * curent_speed * player_movement_magnitude * delta
	position = position.clamp(left_limit, right_limit)

#setup for player getting hit
func _on_body_entered(body: Node2D) -> void:
	if(animation_state != "dodge"):
		print("Hit")

#Called when an animation for the ship is finished
#Return to the normal state
func _animation_finished() -> void:
	print("Animation Stoped")
	animation_state = "normal"
	animation_player.flip_h = false
	animation_player.stop()
		
