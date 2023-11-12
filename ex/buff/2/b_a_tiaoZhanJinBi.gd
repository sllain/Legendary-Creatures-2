extends Buff

func _data():
	name = "金币挑战"
	isDie = false
	isLong = true
	maxLv = 50
	tab = ""
	lock = -1
	isVis = false

var totalLv = 0
var rate = 0

func getDec():
	return tr("增伤和减伤+50%，获胜后可获得额外金币") 

func _in():
	for cha in sys.batScene.getAllChas():
		if cha == null:continue
		if cha.team == sys.player.team:continue
		totalLv += cha.lv
		cha.connect("onHurtStart",self,"getHurt")
		cha.connect("onCastHurtStart",self,"onDmg")
	sys.game.connect("onBattleEnd",self,"battleEnd")

func inStart(mas):
	self.mas = sys.player
	_in()
	
func getHurt(atkInfo):
	atkInfo.finalPer -= 0.5

func onDmg(atkInfo):
	atkInfo.finalPer += 0.5

func battleEnd(isWin):
	if isWin:
		sys.player.items.addItem(data.newBase("m_gold").setNum(totalLv*rate))
	del()
