extends Chara

func _data():
	name = "野蛮人"
	tab = "战士 狂战士"
	animFile = "res://res/anim/p/p8.tres"
	typeRotio(1)
	skillIds = ["k_c_l_1"]
	#animScale = Vector2(0.5,0.5)
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
