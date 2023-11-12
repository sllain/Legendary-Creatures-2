extends Global

var ids = []
var mids = []
signal onBossDel()
var delN = 0
var lvn = 2
func _data():
	pass

func _in():
	sys.player.items.connect("onChangeItem",self,"_onAddItem")

func _onAddItem(item):
	if item != null && item.id == "m_eMoSoul" && item.num >= 3:
		item.num -= 3
		sys.newMsg(tr("收集到3个恶魔之魂，召唤出苍白剑士"))
		sys.player.addAlterCha(data.newBase("c_m_1_1"))
		
	if item is Mater:
		sys.playSe("Coin.wav")
	else :
		sys.playSe("OpenTreasureChest.wav")
	
func rndMid():
	var id = rnp.chaPool.rndItem(self,"rndCha").id
	ids.append(id)
	return id

func rndCha(cha:Chara):
	if cha.origin.find("魔王仆从") == -1 :return false
	for i in ids:
		if cha.id == i :
			return false
	return true

func getSave():
	var ds = {
		ids = ids,
		delN = delN,
		mids = mids,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("ids",ds)
	dsSet("delN",ds)
	dsSet("mids",ds)

func bossDel():
	delN += 1
	emit_signal("onBossDel")
