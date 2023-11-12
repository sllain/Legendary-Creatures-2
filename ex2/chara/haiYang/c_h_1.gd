extends Chara

func _data():
	name = "美猴王"
	tab = "战士 钝器使"
	animFile = "res://res/anim/haiYang/p1.tres"
	typeRotio(1)
	skillIds = ["k_c_h_1"]
	animScale = Vector2(1.2,1.2)
	animOffset = Vector2(0,15)
	#animFlip = true
	origin = "谜团"
#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
