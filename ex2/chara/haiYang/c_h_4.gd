extends Chara

func _data():
	name = "影龙"
	tab = "刺客 暗杀者"
	animFile = "res://res/anim/haiYang/p4.tres"
	typeRotio(4)
	skillIds = ["k_c_h_4"]
	animScale = Vector2(1.3,1.3)
	animOffset = Vector2(-2,15)
	origin = "谜团"

#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
