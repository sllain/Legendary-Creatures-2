extends Chara

func _data():
	name = "兰斯"
	tab = "法师 雷法"
	animFile = "res://res/anim/p/p13.tres"
	typeRotio(5)
	ran = 2
	skillIds = ["k_c_l_5"]
	origin = "驱魔联盟"
	
#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
