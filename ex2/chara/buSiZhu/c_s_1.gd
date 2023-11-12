extends Chara

func _data():
	name = "亡灵武士"
	tab = "战士 剑士"
	animFile = "res://res/anim/p_2/Red Ogre.tres"
	typeRotio(1)
	skillIds = ["k_c_s_1"]
	#animScale = Vector2(0.5,0.5)
	#animFlip = true
	origin = "祭坛"
#	lockType = 1
#	lock = 0
	achDec = "通关难度1"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 1 :
		achCom()
