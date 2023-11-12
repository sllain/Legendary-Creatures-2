extends Buff

func _data():
	name = "挑战中"
	isDie = false
	isLong = true
	maxLv = 50
	tab = ""
	lock = -1
	isVis = false

func getDec():
	return tr("增伤和减伤+50%") 

func _in():
	masCha.connect("onHurtStart",self,"getHurt")
	masCha.connect("onCastHurtStart",self,"onDmg")
	sys.game.connect("onBattleEnd",self,"atEnd")

func getHurt(atkInfo):
	atkInfo.finalPer -= 0.5

func onDmg(atkInfo):
	atkInfo.finalPer += 0.5

func atEnd(isWin):
	del()
