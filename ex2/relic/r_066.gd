extends Relic

func _data():
	name = "贵重物品"
	lock = 0
	
func getDec():
	return tr("玩家售卖物品时，售价提升%d%%") % [lvPer(lv,20)]

func _in():
	sys.player.connect("onSell",self,"r")

func r(item):
	item.price *= 1 + lvPer(lv,0.20)
