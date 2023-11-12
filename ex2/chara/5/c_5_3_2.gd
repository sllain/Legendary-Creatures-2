extends Chara

func _data():
	name = "长老"
	tab = "法师 雷法"
	animFile = "res://res/anim/undead/2.tres"
	typeRotio(5)
	skillIds = ["k_503_2"]
	animOffset = Vector2(-3,12)
	#animScale = Vector2(0.5,0.5)
	#animFlip = true
	origin = "城镇"
	lock = 0
