extends Chara

func _data():
	name = "风元素"
	tab = "射手 飞刺兽"
	animFile = "res://res/anim/p_1/Wind Wisp.tres"
	typeRotio(5)
	skillIds = ["k_201_2"]
	#animScale = Vector2(0.5,0.5)
	#animFlip = true
	animOffset = Vector2(0,0)
	lock = -1
	origin = "元素"
