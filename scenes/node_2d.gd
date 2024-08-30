extends Node2D

@onready var path_2d: Path2D = $Path2D
@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var line_2d: Line2D = $Line2D

func _ready():
	var points = path_2d.curve.get_baked_points()
	
	collision_polygon_2d.polygon = points
	line_2d.points = points
	polygon_2d.polygon = points
