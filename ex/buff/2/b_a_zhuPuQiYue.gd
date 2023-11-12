extends Buff

func _data():
	name = "角色偷取中"
	isDie = false
	isLong = true
	maxLv = 50
	tab = "buff"
	lock = -1
	isVis = false

var enemyChas = []
var rate = 0.0

func getDec():
	return tr("回合胜利后，概率获取一个敌方角色") 

func _in():
#	masCha.connect("onHurtStart",self,"getHurt")
#	masCha.connect("onCastHurtStart",self,"onDmg")
	for cha in sys.batScene.getAllChas():
		if cha == null:continue
		if cha.team == sys.player.team:continue
		if cha.isBoss == false and cha.isSummon == false:
			enemyChas.append(cha.id)
	if not sys.game.is_connected("onBattleEnd",self,"battleEnd"):
		sys.game.connect("onBattleEnd",self,"battleEnd")

func battleEnd(isWin):
	if isWin and enemyChas.size() > 0 and sys.rndPer(rate):
		sys.player.addAlterCha(data.newBase(sys.rndListItem(enemyChas)))
	del()

func inStart(mas):
	self.mas = null
	_in()
	
