extends Chara

func _data():
	name = "侠女"
	tab = "刺客 侠客"
	animFile = "res://res/anim/p/p17.tres"
	typeRotio(4)
	skillIds = ["k_c_l_4"]
	animOffset = Vector2(0,0)
	origin = "驱魔联盟"

#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
