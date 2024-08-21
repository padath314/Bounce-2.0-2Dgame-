extends RigidBody2D
@onready var face: Sprite2D = $Sprite2D/face

@export var speed = 500.0
@export var jump_strength = 20000.0
@export var gravity = 1000.0
@export var roll_torque = 50000.0  # Torque to apply for rolling

var on_ground = false

func _ready():
	# Apply the global texture to the Sprite
	if face and GlobalData.ball_texture:
		face.texture = GlobalData.ball_texture
	
	if GlobalData.ball_texture == null:
		var texture = load("res://assets/ball_blue_large.png")  # Path to your texture file
		face.texture = texture

func set_texture(new_texture: Texture) -> void:
	if face:
		face.texture = new_texture
	else:
		print("Sprite node not found")
	

func _physics_process(delta):
	# Apply gravity manually
	if not on_ground:
		apply_central_force(Vector2(0, gravity))

	# Handle horizontal rolling movement
	if Input.is_action_pressed("right"):
		apply_torque_impulse(roll_torque * delta)  # Apply negative torque to roll right
	elif Input.is_action_pressed("left"):
		apply_torque_impulse(-roll_torque * delta)   # Apply positive torque to roll left

	# Handle jumping 
	# NOT WORKING
	if Input.is_action_just_pressed("jump") and on_ground:
		apply_central_impulse(Vector2(0, -jump_strength))
		on_ground = false

	# Detect if the ball is on the ground (using collision detection)
	on_ground = is_on_floor()

func is_on_floor() -> bool:
	# Check if the ball is colliding with the floor
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.new()
	query.from = global_position
	query.to = global_position + Vector2(0, 1) * 10  # Check slightly below the ball
	query.collision_mask = 2  # Adjust collision mask based on your game setup

	var result = space_state.intersect_ray(query)
	return result.size() > 0
