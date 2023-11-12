extends Chara

func _data():
	name = "水行者"
	tab = "法师 冰法"
	animFile = "res://res/anim/haiYang/p5.tres"
	typeRotio(5)
	ran = 3
	skillIds = ["k_c_h_5"]
	origin = "谜团"
	animScale = Vector2(1.2,1.2)
	animOffset = Vector2(-4,15)
#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
