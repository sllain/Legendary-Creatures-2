extends Chara

func _data():
	name = "巨蟹"
	tab = "坦克 重甲士"
	animFile = "res://res/anim/haiYang/p3.tres"
	typeRotio(3)
	skillIds = ["k_c_h_3"]
	animScale = Vector2(1.4,1.4)
	animOffset = Vector2(0,18)
	origin = "谜团"

#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
