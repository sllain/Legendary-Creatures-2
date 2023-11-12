extends Faci
class_name FaciTown

var items = ItemPck.new()
var chas = ItemPck.new()
var chasUp = true
var itemsUp = true

func _data():
	name = "城镇"
	isShowIco = false
	isCs = true
	isPressed = true
	dec = "休息治疗,雇佣单位,购买物品等等"
	weight = 2
	num = nums.size()
	tab = "world"
	
const nums = [1,1,1,1,1,2,2,2,2,2,3,3,3,3,4,4,4,4]
	
func _createStart():
	createLv = nums[0]
	nums.remove(0)
	
func _in():
	name = ["村庄","小镇","城堡","城堡"][clamp(lv-1,0,3)]
	
func _initInfo():
	initItems()
	initChas()
	
func initItems():
	items.clear()
	for i in 3:
		var item = data.newBase(rnp.eqpPool.rndItem().id)
		item.create(clamp(lv,1,5))
		items.addItem(item)
	for i in 3:
		var item = data.newBase(rnp.csbPool.rndItem().id)
		item.lv = clamp(lv,1,5)
		items.addItem(item)
	for i in 2:
		if lv > 3 :
			var item = data.newBase(rnp.gemUnPool.rndItem().id)
			item.lv = 4
			items.addItem(item)
		else:
			var item = data.newBase(rnp.gemPool.rndItem().id)
			item.lv = clamp(lv,2,5)
			items.addItem(item)
	return items
		
func initChas():
	chas.clear()
	for i in 3 :
		var cha = data.newBase(rnp.chaPool.rndItem(self,"rf").id)
		for j in clamp(lv,1,5) - 1:
			cha.aiPlusLv()
#		for j in cha.skills.items:
#			j.lv = cha.lv
		cha.xp = 0
		cha.sp = cha.spStup * (lv - 1)
		chas.addItem(cha)
	return chas

func rf(cha:Chara):
	if cha.origin.find("城镇") == -1 :
		return false
	for i in chas.items:
		if i.id == cha.id :
			return false
	return true

func _trig():
	sys.eventDlg.txt(dec,true)
	var inx = 0
	if sys.game.globals.has("g_game") :
		inx = yield(sys.eventDlg.sel([tr("休息"),tr("雇佣"),tr("市场"),tr("离开")]),"onSel")
	else:
		inx = yield(sys.eventDlg.sel([tr("雇佣"),tr("市场"),tr("离开")]),"onSel")
		inx += 1
	if inx == 0:
		sys.eventDlg.txt(tr("部队在城镇休息了 %s，回复满了生命值！") % sys.getTimeStr(sys.game.globals.g_game.restTime))
		sys.game.nextTime(sys.game.globals.g_game.restTime)
		for i in sys.player.team.chas :
			i.revive(false)
			i.plusHp(i.maxHp)
	elif inx == 1 :
		var dlg = sys.eventDlg.buyCha(chas)
		if chasUp :
			dlg.reUpBtn.link(10,self,"initChas")
			dlg.reUpBtn.connect("onReUp",self,"reUp",[0])
	elif inx == 2 :
		var dlg = sys.eventDlg.buy(items)
		if itemsUp :
			dlg.reUpBtn.link(10,self,"initItems")
			dlg.reUpBtn.connect("onReUp",self,"reUp",[1])

func reUp(inx):
	if inx == 0 :
		chasUp = false
	elif inx == 1 :
		itemsUp = false
	
func getSave():
	var ds = {
		items = items.getSave(),
		chas = chas.getSave(),
		chasUp = chasUp,
		itemsUp = itemsUp,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	items = ItemPck.new().setSave(ds.items)
	chas = ItemPck.new().setSave(ds.chas)
	dsSet("chasUp",ds)
	dsSet("itemsUp",ds)
