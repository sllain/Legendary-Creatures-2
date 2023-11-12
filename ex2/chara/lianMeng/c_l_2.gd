extends Chara

func _data():
	name = "圣枪手"
	tab = "射手 火枪手"
	animFile = "res://res/anim/undead/5.tres"
	typeRotio(2)
	skillIds = ["k_c_l_2"]
	#animScale = Vector2(0.5,0.5)
	animOffset = Vector2(0,-3)
	#animFlip = true
	origin = "驱魔联盟"

#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
