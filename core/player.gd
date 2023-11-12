extends Faci
class_name Player

signal onAddAlterCha(cha)
signal upChas()
signal onUpLv()
signal onSetMaxPopl()
signal onSell(item)

var popl = 0
var maxPopl = 3 setget setMaxPopl 
var poplSub = 3
var csbNum = 3 #每场战斗可用道具次数
var team:Team = Team.new()
var items :ItemPck = ItemPck.new()
var relics :ItemPck = ItemPck.new()
var maxWeight = 10
var worldCell = Vector2.ZERO
var upSkillNum = 3

func _init():
	name = "你"
	dec = "你的部队"
	visible = true
	
func setMaxPopl(val):
	maxPopl = val
	emit_signal("onSetMaxPopl")

func addAlterCha(cha):
	var ds = {}
	for i in team.chas :
		if i.cell.x >= 5 :
			ds[i.cell] = i
	for x in range(9,4,-1):
		for y in range(7):
			if ds.has(Vector2(x,y)) == false:
				team.addCha(cha)
				cha.cell = Vector2(x,y)
				cha.upSkillsReady()
				emit_signal("onAddAlterCha",cha)
				return true
	return false
	
func _in():
	._in()
	relics.connect("onAddItem",self,"_onAddRelics")
	sys.game.connect("onChaPlusLv",self,"_chaPlusLv")
	###########################
		
#########################	
func _chaPlusLv(cha):
	if cha.team == team:
		upBatLv()

func _onAddRelics(rel,inx):
	rel.inStart(self)

func newData():
	sys.player.items.addItem(data.newBase("m_cry").setNum(0))
	sys.player.items.addItem(data.newBase("m_xp").setNum(0))
	sys.player.items.addItem(data.newBase("m_gold").setNum(0))
#	addAlterCha(data.newBase("c_1_1"))
#	addAlterCha(data.newBase("c_1_3"))
		
func getNowPopl():
	var popl = 0
	for i in sys.player.team.chas:
		popl += i.pop
	return popl
	
func plusPopl():
	if subItem("m_cry",poplSub) :
		maxPopl += 1
		poplSub += 1
	else:
		sys.newMsg("晶石 不足")

func getSave():
	var ds = {
		popl = popl,
		maxPopl = maxPopl,
		worldCell = worldCell,
		team=team.getSave(),
		items = items.getSave(),
		relics = relics.getSave(),
		maxLv = maxLv,
		upSkillNum = upSkillNum,
	}
	ds.merge(.getSave())
	return  ds
	
func setSave(ds):
	.setSave(ds)
	relics.connect("onAddItem",self,"_onAddRelics")
	dsSet("popl",ds)
	dsSet("maxPopl",ds)
	dsSet("worldCell",ds)
	dsSet("maxLv",ds)
	dsSet("upSkillNum",ds)
	items = ItemPck.new().setSave(ds.items)
	relics = ItemPck.new().setSave(ds.relics)
	team = Team.new().setSave(ds.team)
	for i in relics.items:
		_onAddRelics(i,0)

func saveData():
	var file = File.new()
	if file.open(sys.game.dataDir + "/player.data",File.WRITE) == OK:
		file.store_var(getSave())
		file.close()
	else:
		print_debug("保存玩家信息失败")

func loadData():
	var file = File.new()
	file.open(sys.game.dataDir + "/player.data",File.READ)
	var ds = file.get_var()
	file.close()
	setSave(ds)

func subItem(id,val=1):
	var item = items.hasIdItem(id)
	if item != null && item.subNum(val):
		return true
	return false
	
func sell(item:Item,num = 1):
	if item.canSell == false :return
	emit_signal("onSell",item)
	num = clamp(num,1,item.num)
	var p = item.price / item.num * cons.priceRatio * num
	if item is Eqp :
		if item.wearer != null: item.wearer.eqps.delItem(item) 
	
	item.num -= num
	var itemL = []
	itemL.append(data.newBase(item.priceId).setNum(p))
	for i in itemL:
		items.addItem(i)
	return itemL
	
func itemSort():
	items.items.sort_custom(self,"sort_ascending")

static func sort_ascending(a, b):
		if a.lv > b.lv:
			return true
		return false
	
func subItems(lvUps):
	if lvUps.size() <= 0 :return true
	var bl = true
	var il = []
	for i in lvUps:
		var item = items.hasIdItem(i)
		if item != null && item.num >= lvUps[i]:
			il.append([item,lvUps[i]])
		else:
			bl = false
	if bl :
		for i in il :
			i[0].subNum(i[1])
		return true
	return false

var maxLv = 1
func upBatLv():
	var lvn = 0
	var qlv = 0
	for i in sys.player.team.chas:
		if i.cell.x < 5 :
			qlv += i.lv
			lvn += 1
	lv = clamp(int(sqrt(qlv * 0.8)),1,6)
	if lv > maxLv :
		maxLv = lv
		self.maxPopl += 1
		emit_signal("onUpLv")
		sys.newMsg("战力等级提升，人口上限 +1")
