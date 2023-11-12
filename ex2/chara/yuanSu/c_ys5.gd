extends Chara

func _data():
	name = "水元素"
	tab = "法师 冰法"
	animFile = "res://res/anim/p_1/Fire Wisp.tres"
	typeRotio(5)
	skillIds = ["k_501_5"]
	#animScale = Vector2(0.5,0.5)
	#animFlip = true
	animOffset = Vector2(0,0)
	lock = -1
	origin = "元素"
