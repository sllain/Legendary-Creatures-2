extends Relic

func _data():
	name = "契约精神"
	
func getDec():
	return tr("解雇单位时，获得%d件等同于解雇单位等级的装备") % [lvPer(lv,1)]

func _in():
	sys.game.connect("onChaFire",self,"r")

func r(cha):
	for i in lvPer(lv,1):
		var item = data.newBase(rnp.eqpPool.rndItem().id).createRndLv(cha.lv,cha.lv)
		var items = ItemPck.new()
		items.addItem(item)
		sys.eventDlg.items(items)
