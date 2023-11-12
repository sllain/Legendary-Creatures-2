extends Chara

func _data():
	name = "骷髅射手"
	tab = "射手 弓手"
	animFile = "res://res/anim/buSiZhu/1.tres"
	typeRotio(2)
	skillIds = ["k_c_s_2"]
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
