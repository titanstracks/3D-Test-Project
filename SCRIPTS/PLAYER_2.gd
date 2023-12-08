extends CharacterBody3D

@onready var cam_mount = $CAM_MOUNT
@onready var animation_player = $CollisionShape3D/VISUALS/AK_template/AnimationPlayer


@onready var visuals = $CollisionShape3D/VISUALS

const SPEED = 30
const JUMP_VELOCITY = 13

@export var sens_horizontal = 0.5 # MOUSE SENSISITIVITY - H
@export var sens_vertical = 0.5 # MOUSE SENSISITIVITY - V
@export var R_sens_horizontal = 0.05 # RSTICK SENSISITIVITY - H
@export var R_sens_vertical = 0.05 # RSTICK SENSISITIVITY - V

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.get_connected_joypads()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x))
		cam_mount.rotate_x(deg_to_rad(-event.relative.y))


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("L_left", "L_right", "L_forward", "L_backward")
	var direction = (transform.basis * Vector3(input_dir.x*sens_horizontal, 0, input_dir.y*sens_vertical)).normalized()
	if direction:
		visuals.look_at(position + direction)
		animation_player.play("RUNNING")
			
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		animation_player.play("IDLE")
			
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	#if direction:
		#velocity.x = 0  
		#animation_player.play("IDLE")
		#
	#else:
		#if direction:
			#velocity.z = 0
			#animation_player.play("IDLE")
		
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
	
	move_and_slide()

