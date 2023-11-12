extends Chara

func _data():
	name = "操魂者"
	tab = "辅助 牧师"
	animFile = "res://res/anim/p_3/Reaper.tres"
	typeRotio(6)
	skillIds = ["k_c_s_6"]
	animOffset = Vector2(0,0)
	animScale = Vector2(1.5,1.5)
	origin = "祭坛"

#	lockType = 1
#	lock = 0
	achDec = "通关难度1"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 1 :
		achCom()
