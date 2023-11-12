extends Chara

func _data():
	name = "火元素"
	tab = "法师 火法"
	animFile = "res://res/anim/p_1/Fire Wisp.tres"
	typeRotio(5)
	skillIds = ["k_c_5_2_2"]
	#animScale = Vector2(0.5,0.5)
	#animFlip = true
	animOffset = Vector2(0,0)
	lock = 0
	origin = "地牢"
