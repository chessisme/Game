extends Line2D

@export var length = 20
var offset_from_parent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var i = 0
	for point in points:
		set_point_position(i,Vector2(points[i].x,points[i].y + 1000 *delta))
		if(i<points.size()-1):
			i+=1
			
	add_point(get_parent().position)
	
	while get_point_count() > length:
		remove_point(0)
	
