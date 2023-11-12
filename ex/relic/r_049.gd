extends Relic

func _data():
	name = "食腐之心"
	
func getDec():
	return tr("战斗结束有%d%%概率获得对应战斗等级的随机普通消耗品") % [lvPer(lv,15)]

func _in():
	sys.game.connect("onBattleEnd",self,"r")

func r(isWin):
	if sys.rndPer(lvPer(lv,0.15)):
		var item = data.newBase(rnp.csbPool.rndItem().id)
		item.lv = sys.batScene.lv
		sys.player.items.addItem(item)
