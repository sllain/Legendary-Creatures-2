extends Chara

func _data():
	name = "尸镰"
	tab = "法师 魔武者"
	animFile = "res://res/anim/buSiZhu/3.tres"
	typeRotio(1)
	ran = 2
	skillIds = ["k_c_s_5"]
	animScale = Vector2(1.1,1.1)
	origin = "祭坛"
	
#	lockType = 1
#	lock = 0
	achDec = "通关难度1"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 1 :
		achCom()
