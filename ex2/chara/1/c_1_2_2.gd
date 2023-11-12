extends Chara

func _data():
	name = "食人魔"
	tab = "战士 钝器使"
	animFile = "res://res/anim/p_1/Ogre.tres"
	typeRotio(1)
	skillIds = ["k_c_1_2_2"]
	animOffset = Vector2(5,0)
	#animScale = Vector2(0.5,0.5)
	#animFlip = true
	lock = 0
	origin = "地牢"
