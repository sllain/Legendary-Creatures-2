extends Chara

func _data():
	name = "土元素"
	tab = "坦克 肉霸"
	animFile = "res://res/anim/p_1/Earth Wisp.tres"
	typeRotio(5)
	skillIds = ["k_303_2"]
	animScale = Vector2(1.4,1.4)
	#animFlip = true
	animOffset = Vector2(0,0)
	lock = -1
	origin = "元素"
