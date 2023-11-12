extends Chara

func _data():
	name = "仙女鱼"
	tab = "射手 弩手"
	animFile = "res://res/anim/haiYang/p2.tres"
	typeRotio(2)
	skillIds = ["k_c_h_2"]
	animScale = Vector2(1.2,1.2)
	animOffset = Vector2(-5,10)
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
