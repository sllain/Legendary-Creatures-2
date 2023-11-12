extends Relic

func _data():
	name = "重整旗鼓"
	
func getDec():
	return tr("单位战死，在战斗结束后能额外恢复%d%%的生命值") % [lvPer(lv,30)]

func _in():
	sys.game.connect("onBattleEnd",self,"r")

func r(isWin):
	for i in sys.batScene.getAllChas():
		if i.team == sys.player.team and i.isDeath:
			i.revive(false)
			i.plusHp(i.maxHp * lvPer(lv,0.3))
