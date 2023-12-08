extends Area3D
@onready var audio_stream_player_3d = $AudioStreamPlayer3D

const ROT_SPEED = 2 # number of degrees coin rotates every frame 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotate_y(deg_to_rad(ROT_SPEED))

#func _on_body_entered(body):
	##$"../../Player/AUDIO/COIN_AUDIO".play()
 
	#Global.score += 1
	#Global.hp += 10
	#await get_tree().create_timer(.1).timeout
	#queue_free()

