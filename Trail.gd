extends Line2D

@export var length = 50
var offset_from_parent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	offset_from_parent = get_parent().global_position - position
	var i = 0
	for point in points:
		set_point_position(i,Vector2(points[i].x,points[i].y + 500 *delta))
		if(i<points.size()-1):
			i+=1
			
	add_point(to_global(position))
	
	while get_point_count() > length:
		remove_point(0)
	
