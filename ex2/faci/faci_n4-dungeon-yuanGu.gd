extends Faci

func _data():
	name = "远古遗迹"
	dec = "只有收集金色地牢之匙 才可进入"
	weight = 1
	isShowIco = false
	icoId = "ico_faci_batYouAn2"
	tab = "world"
	isCs = true
	num = 1
	lockType = 1 
	lock = 0
	achDec = "通关难度4"
	createLv = 3

var dId = ""
var isOpen = false

func _in():
	lv = 5
	sys.mapScene.map.set_cellv(cell,21)

func _trig():
	if data.isUsable(self) == false:
		sys.eventDlg.txt(tr("通关难度5开启"))
		return
	if isOpen == false:
		if sys.player.subItem("m_key",3) :
			isOpen = true
			sys.eventDlg.txt(tr("消耗了3把黄金钥匙，打开了遗迹的大门"))
		else:
			sys.eventDlg.txt(tr("只有收集3把黄金钥匙，才能打开远古遗迹"))
			return
	var inx = yield(sys.eventDlg.sel([tr("进入"),tr("离开")]),"onSel")
	if inx == 0 :
		var isInit = dId == ""
		dId = sys.game.getRndDungeonId(dId)
		sys.game.toMap(dId,Vector2(50,50),lv)
		sys.player.worldCell = cell
		if isInit :
			var efaci = data.newBase("faci_batBoss")
			efaci.cell = sys.mapScene.getNullCell(sys.mapScene.map.endCell)
			efaci.lv = lv
			sys.mapScene.addObj(efaci)
			if lv >= 3 :
				efaci = data.newBase("faci_batYouAn2")
				efaci.cell = sys.mapScene.getNullCell(sys.mapScene.map.endCell)
				efaci.lv = lv
				sys.mapScene.addObj(efaci)

func getSave():
	var ds = {
		dId = dId,
		isOpen = isOpen,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("dId",ds)
	dsSet("isOpen",ds)

func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 4 :
		achCom()

