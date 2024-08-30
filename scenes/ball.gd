extends RigidBody2D
@onready var face: Sprite2D = $Sprite2D/face
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


@export var speed = 500.0
@export var jump_strength = 500.0
@export var gravity = 1000.0
@export var roll_torque = 20000.0  # Torque to apply for rolling
@export var force = 1000.0

var on_ground = false

func _ready():
	# Set density to be 2
	set_mass(1.0)
	
	# Apply the global texture to the Sprite
	if face and GlobalData.ball_texture:
		face.texture = GlobalData.ball_texture
	
	if GlobalData.ball_texture == null:
		var texture = load("res://assets/ball_blue_large.png")  # Path to your texture file
		face.texture = texture
		
	$RayCast2D.enabled = true
	
func set_texture(new_texture: Texture) -> void:
	if face:
		face.texture = new_texture
	else:
		print("Sprite node not found")
	
func _physics_process(delta):
	# Keep RayCast2D pointing downward in world space (+y direction)
	$RayCast2D.target_position = Vector2(0, 50).rotated(-rotation)
	# Apply gravity manually
	if not on_ground:
		apply_central_force(Vector2(0, gravity))

	# Handle horizontal rolling movement
	if Input.is_action_pressed("right"):
		apply_central_force(force * Vector2(1,0))
		apply_torque_impulse(roll_torque * delta)  # Apply negative torque to roll right
	elif Input.is_action_pressed("left"):
		apply_central_force(force * Vector2(-1,0))
		apply_torque_impulse(-roll_torque * delta)   # Apply positive torque to roll left

	# Handle jumping 
	if Input.is_action_just_pressed("jump") and on_ground:
		apply_central_impulse(Vector2(0, -jump_strength))
		on_ground = false

	# Detect if the ball is on the ground (using collision detection)
	on_ground = is_on_floor()

func is_on_floor() -> bool:
	return $RayCast2D.is_colliding()
	
func get_size() -> float:
	var collision_shape = collision_shape_2d.shape
	return collision_shape.radius
