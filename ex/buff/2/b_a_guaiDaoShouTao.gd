extends Buff

func _data():
	name = "装备偷取中"
	isDie = false
	isLong = true
	maxLv = 50
	tab = ""
	lock = -1
	isVis = false

var enemyChas = []
var rate = 0.0

func getDec():
	return tr("回合胜利后，概率获取一件装备") 

func _in():
#	masCha.connect("onHurtStart",self,"getHurt")
#	masCha.connect("onCastHurtStart",self,"onDmg")
	sys.game.connect("onBattleEnd",self,"battleEnd")
	for cha in sys.batScene.getAllChas():
		if cha == null:continue
		if cha.team == sys.player.team:continue
		if cha.isSummon == false:
			for item in cha.eqps.items:
				if item == null:continue
				enemyChas.append(item.id)

func battleEnd(isWin):
	if isWin and enemyChas.size() > 0 and sys.rndPer(rate):
		sys.player.items.addItem(data.newBase(sys.rndListItem(enemyChas)))
	del()

func inStart(mas):
	self.mas = null
	_in()
	
