extends Chara

func _data():
	name = "骷髅盾卫"
	tab = "坦克 盾卫"
	animFile = "res://res/anim/buSiZhu/2.tres"
	typeRotio(3)
	skillIds = ["k_c_s_3"]
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
