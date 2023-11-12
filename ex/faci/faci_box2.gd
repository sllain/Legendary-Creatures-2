extends Faci

func _data():
	name = "铁箱"
	dec = ""
	weight = 0.5
	num = 5
	tab = "world dungeon"
	dnum = 1

func _trig():
	open()
	
func open():
	var itemPck = ItemPck.new()
	var i1 = data.newBase("m_gold")
	i1.num = lvPer(1,200)
	itemPck.addItem(i1)
	
	var item = data.newBase(rnp.csbPool.rndItem().id)
	item.lv = lv
	itemPck.addItem(item)
	trigInfo("boxOpen",itemPck)
	if sys.game.mode == "map" :
		itemPck.addItem(getRndEqp(rndLv(lv+2)))
	else:
		eqpSelDlg(clamp(lv,2,4))
	sys.eventDlg.items(itemPck)
	del()
