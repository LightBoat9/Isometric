extends Node

func addv(vec, num):
	return Vector2(vec.x + num, vec.y + num)

func point_directionv(a, b):
	return Vector2(b.x - a.x, b.y - a.y)