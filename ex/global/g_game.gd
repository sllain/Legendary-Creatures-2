extends Global

var newGameChas:ItemPck
var hcTime = 3
var restTime = 3
var popNum = 0
var gold = 300
var jtip = 0

func _data():
	excMode = "tower"

func _in():
	sys.game.connect("onOutDungeon",self,"_onOutDungeon")
	sys.game.connect("onNewGame",self,"newGame")
	sys.game.connect("onBattleStart",self,"_battleStart")
	
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
	sys.eventDlg.txt(tr("打败最高峰的魔王即可获得胜利，在这之前你可以任意探索大陆，积累战力。"))
	if sys.isDemo : sys.eventDlg.txt(tr("试玩版只能体验到%d天") % sys.demoDay)
	sys.eventDlg.txt("请雇佣%d个初始单位" % 2)
	var buyCha = sys.eventDlg.buyCha(getGameChas())
	buyCha.reUpBtn.link(0,self,"getGameChas")
	yield(buyCha,"onSel")
	sys.player.items.addItem(data.newBase("m_gold").setNum(300))
	sys.eventDlg.txt(tr("获得 %dG初始金币") % gold)

	if sys.isTest :
		var cha = data.newBase("c_4_3_2")
		sys.player.addAlterCha(cha)
		cha.skills.addItem(data.newBase("k_c_m_2"))

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

func _onOutDungeon():
	sys.newMsg(tr("离开地牢，时间推进 %s") % sys.getTimeStr(hcTime))
	sys.game.nextTime(hcTime)

func getSave():
	var ds = {
		jtip = jtip,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("jtip",ds)

