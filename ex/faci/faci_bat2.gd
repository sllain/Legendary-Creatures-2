extends FaciBat

func _data():
	name = "精英敌人"
	dec = ""
	weight = 4
	num = 30
	tab = "world dungeon"
	powM = 20
	xp = 16
	dnum = 2
	canPerfect = false
	batTime = 0.666
	gold = 50
	repHp = 0.6
		
func bonus(itemPck:ItemPck):
	var item = data.newBase("m_gold")
	item.num = lvPer(lv,gold * bonusR)
	itemPck.addItem(item)
	item = data.newBase("m_xp")
	item.num = nowXp
	itemPck.addItem(item)
	if sys.game.mode == "map" :
		itemPck.addItem(getRndEqp(rndLv(lv * bonusR)))
	else:
#		item = data.newBase("m_cry")
#		item.num = lvPer(lv,3,0.3) * lvPer(sys.game.diffLv,1,0.05) * bonusR
#		itemPck.addItem(item)
		eqpSelDlg(clamp(lv,1,4))
