extends Chara

func _data():
	name = "帕拉丁"
	tab = "辅助 圣骑士"
	animFile = "res://res/anim/p/p0.tres"
	typeRotio(3)
	skillIds = ["k_c_l_6"]
	animOffset = Vector2(0,0)
	#animScale = Vector2(1.5,1.5)
	origin = "驱魔联盟"

#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
