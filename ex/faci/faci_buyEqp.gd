extends FaciBuy

func _data():
	name = "装备商人"
	dec = "7折购买物品，错过不再来"
	weight = 0.5
	tab = "world"
	num = 5

func _initInfo():
	items.items.clear()
	for i in 3:
		var item = data.newBase(rnp.eqpPool.rndItem().id)
		item.createRndLv(lv)
		items.addItem(item)
		item.price *= 0.7
