extends RigidBody2D

@onready var animator = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play()




func animation_finished() -> void:
	queue_free()
