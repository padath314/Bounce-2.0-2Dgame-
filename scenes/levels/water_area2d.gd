extends Area2D


@export var buoyancy_dir = Vector2(0,-1)
@export var liquid_density = 70 # Density of the liquid (e.g., water = 1.0)
@export var drag_coefficient = 0.47  # Drag coefficient for a sphere (adjust as needed)
@export var linear_damping = 10.0  # Linear damping factor for water resistance
@export var angular_damping = 5.0  # Angular damping factor for water resistance


func _on_body_entered(body: Node2D) -> void:
	print("on_area_body_entered")
	if body is RigidBody2D:
		body.set_physics_process(true)
		
		body.linear_damp = linear_damping
		body.angular_damp = angular_damping
		
		# Calculate the body's density
		var volume = 1.2 
		#print(get_ratio_submerged(body))
		var body_density = body.mass / 1.2
		#print("Ball density = ",body_density)
		var buoyant_force = liquid_density * volume * buoyancy_dir * gravity 
		#print(buoyant_force)
		body.apply_central_force(buoyant_force)


func _on_body_exited(body: Node2D) -> void:
	print("Body exited")
	body.set_physics_process(true)
	# Reset damping when the body exits the water
	if body is RigidBody2D:
		body.linear_damp = 0
		body.angular_damp = 0

func get_ratio_submerged(body : RigidBody2D):
	var y = body.position.y
	var d = y - 300.0
	
	if d > body.get_size():
		return 0.0
	
	if d < -(body.get_size()):
		return 1.0
	
	var r = body.get_size()
	var submerged_area = r*r*acos(d/r) - d*sqrt(r*r - d*d)
	var total_area = PI*r*r
	
	return submerged_area / total_area
