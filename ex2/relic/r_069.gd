extends Relic

func _data():
	name = "宝石矿工"
	lock = 0
	
func getDec():
	return tr("击杀地牢的BOSS时，%d%%几率额外获得1个传奇宝石") % [lvPer(lv,40)]

func _in():
	sys.game.connect("onBattleEnd",self,"r")
	
func r(isWin):
	if isWin and sys.batScene.faci.id == "faci_batBoss" and "rndMap" in sys.mapScene.mapId and sys.rndPer(lvPer(lv,0.4)):
		var itemPck = ItemPck.new()
		
		var item = data.newBase(rnp.gemUnPool.rndItem().id)
		item.lv = 4
		itemPck.addItem(item)

		sys.eventDlg.items(itemPck)
