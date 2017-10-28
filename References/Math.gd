extends Node

func addv(vec, num):
	return Vector2(vec.x + num, vec.y + num)
	
func subv(vec, num):
	return Vector2(vec.x - num, vec.y - num)

func point_directionv(a, b):
	return Vector2(b.x - a.x, b.y - a.y)
	
func point_direction(x1, y1, x2, y2):
	return Vector2(x2 - x1, y2 - y1)

func angle_to_vector(angle):
	return Vector2(cos(angle), -sin(angle))
	
func rand_rangev(vmin, vmax):
	randomize()
	return Vector2(rand_range(vmin, vmax), rand_range(vmin, vmax))

func choose(a, b):
	randomize()
	return conditional(rand_range(-1,1) > 0, a, b)

func conditional(condition, a, b):
	if (condition): return a
	return b

func distance_to_point(a, b):
	return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2))