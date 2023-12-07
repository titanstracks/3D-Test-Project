extends Node3D

@onready var cam_mount = $CAM_MOUNT
@onready var visuals = $VISUALS

@export var sens_horizontal = 0.5 # MOUSE SENSISITIVITY - H
@export var sens_vertical = 0.5 # MOUSE SENSISITIVITY - V
@export var R_sens_horizontal = 0.05 # RSTICK SENSISITIVITY - H
@export var R_sens_vertical = 0.05 # RSTICK SENSISITIVITY - V


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.get_connected_joypads()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x))
		cam_mount.rotate_x(deg_to_rad(-event.relative.y))


# Get the R_STICK direction and handle the CAMERA movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	$CAM_MOUNT/Camera3D.rotate_x(Input.get_action_strength("R_forward")*R_sens_vertical)
	$CAM_MOUNT/Camera3D.rotate_x(Input.get_action_strength("R_backward")*R_sens_vertical*-1)
	if($CAM_MOUNT/Camera3D.rotation_degrees.x < -10):
		$CAM_MOUNT/Camera3D.rotation_degrees.x = -10
	elif($CAM_MOUNT/Camera3D.rotation_degrees.x > 10):
		$CAM_MOUNT/Camera3D.rotation_degrees.x = 10
	rotate_y(Input.get_action_strength("R_left")*R_sens_horizontal)
	rotate_y(Input.get_action_strength("R_right")*R_sens_horizontal*-1)

