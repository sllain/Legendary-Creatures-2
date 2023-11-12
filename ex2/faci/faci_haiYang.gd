extends FaciBat

func _data():
	name = "谜团"
	dec = ""
	weight = 0.5
	num = 4
	tab = "world"
	isCs = true
	canPerfect = false
	lv = 5
	origin = "谜团"
	dec = "海上的谜团"
	
var items = ItemPck.new()
var nowItems = ItemPck.new()
	
func _in():
	lv = 5	
	sys.game.connect("onFaciFound",self,"rFound")
	
func _create():
	if sys.game.mode != "map":
		return
	var x = rndRan(2,98)
	var y = rndRan(2,98)
	if x >= 2 && x <= 96 :
		if rndPer(0.5) :y = rndRan(96,98)
		else: y = rndRan(2,4)
	matMoveUp(Vector2(x,y))

func rFound(faci):
	if faci == self :
		for i in sys.mapScene.objs.items: 
			if i.id == "faci_haiYang" && i != self:
				i.del()

var ids = []
var selId = ""

func _initInfo():
	for i in 2 :
		ids.append(rnp.chaPool.rndItem(self,"rfBoss").id)
	
func _trig():
	if team.chas.size() <= 0 :
		sys.eventDlg.txt(tr("你要挑战谁？"),false)
		var bss = []
		for i in ids:
			bss.append(data.newBase(i))
		var inx = yield(sys.eventDlg.selBB([tr(bss[0].name),tr(bss[1].name),tr("离开")]),"onSel")
		if inx != 2 :
			selId = ids[inx]
			enemyInit(25,lv)
			team.chas.clear()
			powVal = initPow(powM)
			var cha = data.newBase(selId) 
			addCha(cha)
			while powVal > 0 :
				addCha(data.newBase(rndListItem(["c_ys1","c_ys2","c_ys5"])) )
				powVal -= 10
			initBoss()
			bat()
	else:bat()

func initBoss():
	var cha:Chara = team.chas[0]
	cha.isBoss = true
	cha.eqps.addItem(data.newBase("eqpo_" + selId))
	cha.addRndItem(clamp(cha.lv-1,1,5))
		
func rfBoss(cha:Chara):
	if cha.origin.find("谜团") == -1 :
		return false
	for i in ids:
		if i == cha.id :
			return false
	return true
		
func bonus(itemPck:ItemPck):
	var item = data.newBase("m_gold")
	item.num = lvPer(lv,80)
	if sys.game.isNight() : item.num *= 1.5
	itemPck.addItem(item)
	item = data.newBase("m_xp")
	item.num = nowXp
	itemPck.addItem(item)
	
	item = data.newBase("m_cry")
	item.num = lvPer(lv,5,0.3) * lvPer(sys.game.diffLv,1,0.1)
	itemPck.addItem(item)
	trigInfo("bossDel")
	
func countEnd(win):
	if win :
		
		sys.eventDlg.txt(tr("胜利，获得奖励。"),true)
		var itemPck = ItemPck.new()
		itemPck.addItem(data.newBase("eqpo_" + selId))
		bonus(itemPck)
		if itemPck.items.size() > 0 :
			sys.eventDlg.items(itemPck)
		var mcha = data.newBase(selId)
		sys.eventDlg.txt(tr("招募了 %s") % mcha.name)
		sys.player.addAlterCha(mcha)
		del()
	else:
		sys.eventDlg.txt(tr("战败!"))

func getSave():
	var ds = {
		ids = ids,
		selId = selId,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("ids",ds)
	dsSet("selId",ds)
