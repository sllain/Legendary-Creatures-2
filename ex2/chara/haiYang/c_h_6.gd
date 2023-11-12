extends Chara

func _data():
	name = "水星人"
	tab = "辅助 炼金术士"
	animFile = "res://res/anim/haiYang/p6.tres"
	typeRotio(6)
	skillIds = ["k_c_h_6"]
	animScale = Vector2(1.3,1.3)
	animOffset = Vector2(-1,15)
	origin = "谜团"

#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
