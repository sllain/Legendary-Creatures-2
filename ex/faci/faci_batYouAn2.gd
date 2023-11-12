extends FaciBatBoss

func _data():
	name = "神圣监牢"
	dec = "关押着神明,只有幽暗值达到满层才可挑战"
	weight = 0.5
	tab = "world"
	lock = -1
	bossBuffLv = 3
	powM = 25
	canPerfect = false

func _trig():
#	sys.eventDlg.txt(tr("为了方便测试，神圣监牢暂时关闭，新的神圣监牢在施工中"))
#	return
	if sys.game.globals.g_dark.lv < sys.game.globals.g_dark.maxLv :
		sys.eventDlg.txt(tr("只有本地牢的幽暗值达到%d层才可挑战") % sys.game.globals.g_dark.maxLv)
		return
	sys.eventDlg.txt("监牢中关押着一个神明，救出他会赐予你神器，但同时会带来一场浩劫",true)
	var inx = yield(sys.eventDlg.selBB([tr("救下他(额外的难度挑战)"),tr("离开")]),"onSel")
	if inx == 0 :
		bat()
	
func initBoss():
	var cha:Chara = team.chas[0]
	cha.isBoss = true
	cha.addRndItem(clamp(cha.lv-1,1,5))
	cha.addRndItem(clamp(cha.lv-1,1,5))

func bonus(itemPck:ItemPck):
	sys.game.globals.g_shenQi.start()
	sys.eventDlg.txt(tr("神授予了你神器，而同时大地图上的所有的常规战斗事件提升1级,包括魔王"))

	var item = data.newBase("m_gold")
	item.num = lvPer(lv,gold * bonusR)
	if sys.game.isNight() : item.num *= 1.5
	itemPck.addItem(item)
	item = data.newBase("m_xp")
	item.num = nowXp
	itemPck.addItem(item)
	
	eqpSelDlg(6)
	
	item = data.newBase("m_cry")
	item.num = lvPer(lv,5,0.3) * lvPer(sys.game.diffLv,1,0.1)
	itemPck.addItem(item)
