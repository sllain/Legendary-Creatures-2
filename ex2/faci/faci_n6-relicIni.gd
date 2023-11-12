extends Faci

func _data():
	name = "初始神徽"
	dec = "获得一个神徽！"
	weight = 1
	num = 1
	tab = "world"
	isCs = true
	glow = true
	lockType = 1
	lock = 0
	achDec = "通关难度6"

func _trig():
	sys.eventDlg.txt(tr("获得一个神徽！"))
	relicDlg()
	del()
	
func _in():
	lv = 0
	if sys.game.mode == "tower" :return
	yield(ctime(0.1),"timeout")
	matMoveUp(sys.mapScene.getNullCell(sys.mapScene.playFaci.cell + Vector2(-1,-1)))
	self.visible = true


func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 6 :
		achCom()
