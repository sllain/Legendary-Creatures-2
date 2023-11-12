extends FaciBatBoss

func _data():
	name = "幽暗监牢"
	dec = "只有幽暗值达到满层才可挑战"
	weight = 0.5
	tab = "world"
	lock = -1
	bossBuffLv = 3
	powM = 25
	canPerfect = false

func _trig():
	if sys.game.globals.g_dark.lv < sys.game.globals.g_dark.maxLv :
		sys.eventDlg.txt(tr("只有本地牢的幽暗值达到%d层才可挑战") % sys.game.globals.g_dark.maxLv)
		return
	bat()
	
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
	
	if lv == 4 :
		ugemSelDlg(5)
	else:
		ugemSelDlg(4)

	itemPck.addItem(data.newBase("m_key").setNum(1))
	item = data.newBase("m_cry")
	item.num = lvPer(lv,5,0.3) * lvPer(sys.game.diffLv,1,0.1)
	itemPck.addItem(item)
