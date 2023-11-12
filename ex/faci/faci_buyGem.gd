extends FaciBuy

func _data():
	name = "宝石商人"
	dec = "7折购买物品，错过不再来"
	weight = 0.5
	tab = "world"
	num = 5

func _initInfo():
	items.items.clear()
	for i in 3:
		var item = data.newBase(rnp.gemPool.rndItem().id)
		item.createRndLv(lv)
		items.addItem(item)
		item.price *= 0.7
	if lv >= 3 :
		var item = data.newBase(rnp.gemUnPool.rndItem().id)
		item.lv = 4
		items.addItem(item)
		item.price *= 0.7
