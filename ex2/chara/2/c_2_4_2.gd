extends Chara

func _data():
	name = "石像鬼陷阱"
	tab = "射手 弩手"
	animFile = "res://res/anim/p/p28.tres"
	typeRotio(2)
	skillIds = ["k_c_2_4_2"]
	animScale = Vector2(1.2,1.2)
	animOffset = Vector2(0,20)
	#animFlip = true
	origin = "城镇"
	lock = 0
