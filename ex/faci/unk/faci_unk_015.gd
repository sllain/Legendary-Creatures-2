extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

func _trig():
	sys.eventDlg.txt(tr("获得 2个随机道具"),true)
	var itemPck = ItemPck.new()
	for i in 2 :
		var item = data.newBase(rnp.csbPool.rndItem().id)
		item.lv = lv
		itemPck.addItem(item)
	sys.eventDlg.items(itemPck)
	del()

