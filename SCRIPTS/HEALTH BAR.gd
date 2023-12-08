extends TextureProgressBar

func _process(_delta):
	self.value = Global.hp

	if(Global.score >= 10):
		self.value = Global.score - 10
	
