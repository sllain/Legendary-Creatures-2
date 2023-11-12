extends Chara

func _data():
	name = "丧尸"
	tab = "刺客 毒枭"
	animFile = "res://res/anim/buSiZhu/4.tres"
	typeRotio(4)
	skillIds = ["k_c_s_4"]
	animOffset = Vector2(0,0)
	origin = "祭坛"
#	lockType = 1
#	lock = 0
	achDec = "通关难度1"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 1 :
		achCom()
