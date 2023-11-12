extends Relic

func _data():
	name = "幸运四叶草"
	
func getDec():
	return tr("战斗胜利后，%d%%概率获得一件装备，装备等级等于队伍战力等级") % [lv * 4]

func _in():
	sys.game.connect("onBattleEnd",self,"r")

func r(isWin):
	if isWin and sys.rndPer(lv * 0.04):
		sys.player.items.addItem(data.newBase(rnp.eqpPool.rndItem().id).createRndLv(sys.game.player.lv,sys.game.player.lv))
