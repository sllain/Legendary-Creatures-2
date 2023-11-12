extends FaciBatBoss

func _data():
	name = "魔王仆从"
	dec = "必掉传奇装备"
	weight = 0.5
	num = 3
	tab = "world"
	bossBuffLv = 3
	powM = 25
	gold = 100
	canPerfect = false
	self.visible = true
	
func countDeath():
	pass
	
func countMiasma():
	pass
	
func _createStart():
	createLv = sys.game.globals.g_puCong.lvn
	
func _create():
	sys.game.globals.g_puCong.lvn += 1
	
var mid = ""
	
func enemyInit(powM,lv):
	team.chas.clear()
	powVal = initPow(powM)
	mid = sys.game.globals.g_puCong.rndMid()
	var cha = data.newBase(mid) 
	addCha(cha)
	while powVal > 0 :
		var rcha = rnp.chaPool.rndItem(self,"rf")
		if rcha != null:
			addCha(data.newBase(rcha.id) )
			powVal -= 10
		else:
			powVal -= 1
	initBoss()

func initBoss():
	var cha:Chara = team.chas[0]
	cha.isBoss = true
	cha.addRndItem(clamp(cha.lv-1,1,5))
	cha.addRndItem(clamp(cha.lv-1,1,5))

func bonus(itemPck:ItemPck):
	var item = data.newBase("m_gold")
	item.num = lvPer(lv,gold * bonusR)
	if sys.game.isNight() : item.num *= 1.5
	itemPck.addItem(item)
	item = data.newBase("m_xp")
	item.num = nowXp
	itemPck.addItem(item)
	
	item = data.newBase("m_cry")
	item.num = lvPer(lv,5,0.3) * lvPer(sys.game.diffLv,1,0.1)
	itemPck.addItem(item)
	
func countEnd(win):
	if win :
		trigInfo("bossDel")
		sys.eventDlg.txt(tr("胜利，获得奖励。"),true)
		var itemPck = ItemPck.new()
		bonus(itemPck)
		if itemPck.items.size() > 0 :
			sys.eventDlg.items(itemPck)
		eqpSelDlg(4)
		
		sys.eventDlg.txt(tr("你选择如何处置魔王仆从？"))
		var ls = [
			tr("招致麾下"),
			tr("斩杀，获得恶魔之魂")
		]
		var inx = yield(sys.eventDlg.selBB(ls),"onSel")
		if inx == 0 :
			var mcha = data.newBase(mid)
			sys.player.addAlterCha(mcha)
		else:
			sys.player.items.addItem(data.newBase("m_eMoSoul"))
		del()
		sys.game.globals.g_puCong.bossDel()
	else:
		sys.eventDlg.txt(tr("战败!"))

func plusLv():
	self.lv += 1
	for i in team.chas:
		i.lv += 1

func getSave():
	var ds = {
		mid = mid,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("mid",ds)
