extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

func _trig():
	sys.eventDlg.txt(tr("低价售卖的宝石"),true)
	var inx = yield(sys.eventDlg.sel([tr("购买"),tr("放弃")]),"onSel")
	if inx == 0 :
		var buy = sys.eventDlg.buy(items)
		buy.connect("onBuy",self,"r")

func _initInfo():
	lv = 4
	items.items.clear()
	for i in 2:
		var item = data.newBase(rnp.gemPool.rndItem().id)
		item.lv = 3
		items.addItem(item)
		item.price *= 0.5
	for i in 2 :
		var item = data.newBase(rnp.gemUnPool.rndItem().id)
		item.lv = 4
		items.addItem(item)
		item.price *= 0.5
		
func r(item):
	if items.items.size() == 0 :
		self.invalid = true
		del()

func getSave():
	var ds = {
		items = items.getSave(),
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	items = ItemPck.new().setSave(ds.items)
