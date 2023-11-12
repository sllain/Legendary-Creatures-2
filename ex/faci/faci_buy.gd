extends Faci
class_name FaciBuy
var items = ItemPck.new()

func _data():
	name = "商人"
	dec = "6折购买物品"
	weight = 1
	lock = -1
	tab = "world"
	icoId = "ico_faci_buyEqp"

func _initInfo():
	items.items.clear()
	for i in 3:
		var item = data.newBase(rnp.eqpPool.rndItem().id)
		item.createRndLv(clamp(lv,1,5))
		items.addItem(item)
		item.price *= 0.6
	for i in 3:
		var item = data.newBase(rnp.csbPool.rndItem().id)
		item.lv = clamp(lv,1,5)
		items.addItem(item)
		item.price *= 0.6

func _trig():
	sys.eventDlg.txt("%s" % [dec],true)
	var inx = yield(sys.eventDlg.sel([tr("购买"),tr("离开")]),"onSel")
	if inx == 0 :
		var buy = sys.eventDlg.buy(items)
		buy.connect("onBuy",self,"r")
		
func r(item):
	if items.items.size() == 0 :
		self.invalid = true

func getSave():
	var ds = {
		items = items.getSave(),
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	items = ItemPck.new().setSave(ds.items)
