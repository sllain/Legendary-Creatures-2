extends Faci

var items = ItemPck.new()

func _data():
	#isShowIco = false
	name = "黑店"
	isCs = true
	isPressed = true
	dec = "这里可以买到贵重的消耗品"
	weight = 2
	num = nums.size()
	tab = "world"
	lock = 0
	lockType = 1
	achDec = "通关难度0"
	
const nums = [1,2,3]
	
func _createStart():
	createLv = nums[0]
	nums.remove(0)
	
func _in():
	name = "黑店"
	if sys.isDemo :
		del()
			 
func _initInfo():
	var rndPool = getRndPool()
	for i in 3:
		var item = data.newBase(rndPool.rndItem().id)
		item.lv = clamp(lv,1,5)
		item.price = 300 * pow(2,item.lv-1)
		items.addItem(item)

func getRndPool():
	var pool = RndPool.new()
	for i in data.getList("csb"):
		var item = data.newBase(i.id) 
		if item.hasTab("黑店") == false: continue 
		if item.lock == -1 : 
			item.priceBase = 300
			pool.addItem(item,item.weight)
	return pool

func _trig():
	sys.eventDlg.txt(dec,true)
	
	var inx = yield(sys.eventDlg.sel([tr("购买贵重消耗品"),tr("离开")]),"onSel")
	if inx == 0:
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

func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 0 :
		achCom()
