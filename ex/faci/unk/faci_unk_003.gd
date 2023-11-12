extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

func _trig():
	lv = 4
	var g = per(50)
	sys.eventDlg.txt(tr("%d 金币 获得 2个%d级随机道具") % [g,lv],true)
	var inx = yield(sys.eventDlg.sel([tr("确定"),tr("放弃")]),"onSel")
	if inx == 0 :
		if sys.player.subItem("m_gold",g) :
			var itemPck = ItemPck.new()
			for i in 2 :
				var item = data.newBase(rnp.csbPool.rndItem().id)
				item.lv = lv
				itemPck.addItem(item)
			sys.eventDlg.items(itemPck)
			del()
		else:
			sys.eventDlg.txt(tr("金币 不足"))
	else:
		del()

