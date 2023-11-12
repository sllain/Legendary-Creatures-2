extends Faci

var chas = ItemPck.new()

func _data():
	#isShowIco = false
	name = "地牢佣兵"
	dec = "这是些在阴暗地牢里的狠角，可以雇佣他们。"
	weight = 2
	tab = "dungeon"
#	lockType = 1
#	lock = 0
	achDec = "通关难度3"
	dnum = 1
	num = 0

var chasUp = true
func _create():
	matMoveUp(sys.mapScene.map.endCell)
	
func _initInfo():
	initChas()

func initChas():
	chas.clear()
	for i in 3 :
		var cha = data.newBase(rnp.chaPool.rndItem(self,"rf").id)
		while chas.hasIdItem(cha.id):
			cha = data.newBase(rnp.chaPool.rndItem(self,"rf").id)
		for j in clamp(lv,1,5) - 1:
			cha.aiPlusLv()
		cha.xp = 0
		cha.sp = cha.spStup * (lv - 1)
		chas.addItem(cha)
	return chas

func rf(cha:Chara):
	if cha.origin.find("地牢") == -1 :
		return false
	for i in chas.items:
		if i.id == cha.id :
			return false
	return true

func _trig():
	sys.eventDlg.txt(dec,true)
	var dlg = sys.eventDlg.buyCha(chas)
	if chasUp :
		dlg.reUpBtn.link(10,self,"initChas")
		dlg.reUpBtn.connect("onReUp",self,"reUp",[0])
		
func reUp(inx):
	if inx == 0 :
		chasUp = false
	
func getSave():
	var ds = {
		chas = chas.getSave(),
		chasUp = chasUp,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	chas = ItemPck.new().setSave(ds.chas)
	dsSet("chasUp",ds)

func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()
