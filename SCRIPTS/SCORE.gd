extends Label

func _process(delta):
	self.text = str(Global.score)


func _on_coin_body_entered(body):
	Global.score += 1

