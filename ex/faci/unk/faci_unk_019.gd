extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

func _trig():
	sys.eventDlg.txt(tr("低价售卖的消耗品"),true)
	var inx = yield(sys.eventDlg.sel([tr("购买"),tr("放弃")]),"onSel")
	if inx == 0 :
		var buy = sys.eventDlg.buy(items)
		buy.connect("onBuy",self,"r")

func _initInfo():
	lv = 4
	items.items.clear()
	for i in 3:
		var item = data.newBase(rnp.csbPool.rndItem().id)
		item.lv = lv
		items.addItem(item)
		item.price *= 0.4
		
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
