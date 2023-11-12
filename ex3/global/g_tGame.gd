extends Global

var newGameChas:ItemPck
var hcTime = 3
var restTime = 3
var popNum = 0
var gold = 300
var jtip = 0

func _data():
	excMode = "map"
	name = "命数"
	dec = "战斗失败扣除命数，命数耗尽游戏失败"
	isVisIco = true
	lv = 3

func _in():
	sys.game.connect("onNewGame",self,"newGame")
	sys.game.connect("onBattleEnd",self,"_batEnd")
	sys.game.connect("onBattleStart",self,"_battleStart")
	sys.game.isTimeOn = false
	
func setLv(val):
	.setLv(val)
	self.txt = "%d" % lv
	
func _battleStart():
	var chas = sys.batScene.getAllChas()
	for i in chas:
		if i.team == sys.player.team :
			if i.hasTab("刺客"):
				i.castBuff(i,"b_a_yinShen",5)
			if i.hasTab("战士"):
				i.castBuff(i,"b_a_plusPer",20)
	
func newGame():
	sys.player.items.addItem(data.newBase("m_gold").setNum(125*2))
	sys.player.items.addItem(data.newBase("m_xp").setNum(0))
	sys.player.items.addItem(data.newBase("m_cry").setNum(data.cry))
	sys.player.items.addItem(data.newBase("csb_001"))
	sys.player.items.addItem(data.newBase("csb_002"))
	sys.player.items.addItem(data.newBase("csb_020"))
	
	#初始选人
	yield(sys.get_tree().create_timer(0.3),"timeout")
	sys.eventDlg.txt("请雇佣%d个初始单位" % 2)
	var buyCha = sys.eventDlg.buyCha(getGameChas())
	buyCha.reUpBtn.link(0,self,"getGameChas")
#	yield(buyCha,"onSel")
#	sys.player.items.addItem(data.newBase("m_gold").setNum(300))
#	sys.eventDlg.txt(tr("获得 %dG初始金币") % gold)
	
#	var item = data.newBase("eqpo_king01") 
#	sys.player.items.addItem(item)

func getGameChas():
	newGameChas = ItemPck.new()
	for i in 6 :
		var cha = data.newBase(rnp.chaPool.rndItem(self,"rndNewGame").id)
		newGameChas.addItem(cha)
	return newGameChas

func rndNewGame(cha):
	if cha.origin.find("城镇") == -1 :
		return false
	for i in newGameChas.items:
		if cha.hasOrTab(i.tab) :
			return false
	return true
	
func _batEnd(isWin):
	if isWin == false:
		self.lv -= 1
		if lv <= 0 :
			sys.game.end(false)

func getSave():
	var ds = {
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)

