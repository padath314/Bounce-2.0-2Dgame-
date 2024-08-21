extends Window

@onready var file_dialog: FileDialog = $FileDialog
@onready var ball: RigidBody2D = $ball

func _ready():
	ball.gravity_scale = 0

func _on_upload_pressed() -> void:
	file_dialog.popup_centered()
	


func _on_file_dialog_file_selected(path: String) -> void:
	var image = Image.new()
	var error = image.load(path)
	
	if error == OK:
		#Create an ImageTexture from the loaded image
		var texture = ImageTexture.new()
		texture = ImageTexture.create_from_image(image)
		
		# Set the texture in the global singleton
		GlobalData.ball_texture = texture
		print("GlobalData.texture : ", GlobalData.ball_texture)
		
		if ball:
			ball.set_texture(texture)
		else:
			print("Ball not found")
	else:
		print("Failed to load image:")


func _on_close_requested() -> void:
	self.hide()
