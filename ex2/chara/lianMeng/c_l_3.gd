extends Chara

func _data():
	name = "石头人"
	tab = "坦克 肉霸"
	animFile = "res://res/anim/p_2/Golem.tres"
	typeRotio(3)
	skillIds = ["k_c_l_3"]
	animOffset = Vector2(5,0)
	origin = "驱魔联盟"

#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
