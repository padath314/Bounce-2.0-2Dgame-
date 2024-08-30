extends Camera2D

@onready var ball: RigidBody2D = $".."
var fixed_y_position = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fixed_y_position = global_position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = $"..".global_position.x
	global_position.y = fixed_y_position
