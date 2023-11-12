extends Chara

func _data():
	name = "熔岩巨人"
	tab = "坦克 重甲士"
	animFile = "res://res/anim/p_3/Fire Golem.tres"
	typeRotio(3)
	skillIds = ["k_c_3_2_2"]
	animOffset = Vector2(5,0)
	#animScale = Vector2(0.5,0.5)
	#animFlip = true
	lock = 0
	origin = "城镇"
