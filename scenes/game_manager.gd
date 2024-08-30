extends Node

var points = 0
@onready var points_label: Label = %PointsLabel

func add_point():
	points += 1
	points_label.text = "POINTS : "+str(points)
