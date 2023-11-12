extends Faci

func _data():
	isCs = true
	isPressed = true
	name = "先知之眼"
	dec = "学习技能时可选项+1"
	weight = 0.5
	tab = "world"
	num = 1
	lockType = 1
	lock = 0
	achDec = "通关难度2"

var g = 800
		
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 2 :
		achCom()

func _in():
	sys.player.upSkillNum += 1
	yield(ctime(0.1),"timeout")
	del()
