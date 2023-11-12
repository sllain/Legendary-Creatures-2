extends Relic

func _data():
	name = "宝石大亨"
	
func getDec():
	return tr("购买宝石时，%d%%的概率提高1级，最高5级") % [lvPer(lv,13)]

func _in():
	sys.game.connect("onBuyItem",self,"r")

func r(item):
	if item is Gem:
		if item.lv < 5 and sys.rndPer(lvPer(lv,0.13)):
			item.lv += 1
