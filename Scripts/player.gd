extends Area2D

@export var normal_speed = 400
@export var dodge_speed = 550
@export var boost_speed = 1000
var curent_speed = 400

@export var animation_player :AnimatedSprite2D
var animation_state = "normal"

var player_movement_vector
var player_movement_magnitude

var screen_size
var left_limit
var right_limit

var touching_list = []

signal hit


func _ready() -> void:
	#get the screen size
	screen_size = get_viewport_rect().size
	#set the camera's starting position
	position = screen_size/2
	position.y = screen_size.y/1.25
	#set the limits of the play area to be used in 
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
			animation_player.set_frame(3)
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
	
	#temporarily print the touching list if it isnt empty
	if(!touching_list.is_empty() and animation_state != "dodge"):
		print(touching_list)

#setup for player getting hit
func _on_body_entered(body: Node2D) -> void:
	touching_list.push_back(body)

func _on_body_exited(body: Node2D) -> void:
	touching_list.erase(body)

#Called when an animation for the ship is finished
#Return to the normal state
func _animation_finished() -> void:
	animation_state = "normal"
	animation_player.flip_h = false
	animation_player.stop()
		
