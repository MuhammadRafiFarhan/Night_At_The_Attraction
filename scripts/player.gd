extends Spatial

onready var cam = $Camera
onready var movement_speed = 5.0  # Adjust the movement speed as needed

var space_dimensions = Vector3(5.8, 5.8, 10.294)

# How close to the border of the screen the mouse has to be to start rotating the view
var pan_x_distance_from_border = 0

signal turn_on_cams
signal turn_off_cams
signal lower_monitor

func _ready():
	# Set it to 1/5th of the screen resolution on the x axis
	pan_x_distance_from_border = Global.screen_resolution.x / 5
	# Set the player camera as the current camera
	cam.current = true

func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()

	# Check if the mouse is close to the left or the right side of the screen, then rotate the view
	if mouse_position.x < pan_x_distance_from_border:
		turn_left(60 * delta)
	elif mouse_position.x > Global.screen_resolution.x - pan_x_distance_from_border:
		turn_right(60 * delta)
	
	# Check for keyboard input to move the player
	var move_direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		move_direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		move_direction.z += 1
	if Input.is_action_pressed("move_right"):
		move_direction.x += 1
	if Input.is_action_pressed("move_left"):
		move_direction.x -= 1
	
	# Normalize and scale the move_direction vector based on movement speed
	move_direction = move_direction.normalized() * movement_speed
	
	# Calculate the target position by adding the move_direction to the current position
	var target_position = translation + move_direction * delta
	
	# Limit the target position within the specified space dimensions
	target_position.x = clamp(target_position.x, -space_dimensions.x / 2, space_dimensions.x / 2)
	target_position.y = clamp(target_position.y, -space_dimensions.y / 2, space_dimensions.y / 2)
	target_position.z = clamp(target_position.z, -space_dimensions.z / 2, space_dimensions.z / 2)
	
	# Move the player to the target position
	translation = target_position

	# Then we make sure the camera doesn't go too far to the right/left
	rotation_degrees.y = clamp(rotation_degrees.y, -20, 20)

func turn_left(speed):
	rotate_y(deg2rad(speed))

func turn_right(speed):
	rotate_y(deg2rad(-speed))

# If the monitor is in the player's face (end of monitor up animation),
# emit signal that will be sent to the CameraViewer node
func facing_monitor():  # Called by the animation
	emit_signal("turn_on_cams")
	cam.current = false

func not_facing_monitor():
	emit_signal("turn_off_cams")
	cam.current = true

# If the player runs out of power or an animatronic kills the player,
# the monitor has to be lowered
func _on_Power_out_of_power():
	$CanvasLayer/MonitorUI.hide()
	if $CanvasLayer/MonitorUI.monitor_up:
		emit_signal("lower_monitor")

func _on_AnimatronicsManager_jumpscare(animatronic):
	$CanvasLayer/MonitorUI.hide()
	if $CanvasLayer/MonitorUI.monitor_up:
		emit_signal("lower_monitor")
