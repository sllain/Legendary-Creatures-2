extends Relic

func _data():
	name = "商人之友"
	
func getDec():
	return tr("购买物品时，返还%d%%的消费") % [lvPer(lv,15)]

func _in():
	sys.game.connect("onBuyItem",self,"r")

func r(item):
	sys.player.items.addItem(data.newBase("m_gold").setNum(item.price*lvPer(lv,0.15)))
