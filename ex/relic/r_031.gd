extends Relic

func _data():
	name = "养身备战"
	
func getDec():
	return tr("战斗结束时，全队回复%d%% 生命值") % [lvPer(lv,9)]
	
func _in():
	sys.game.connect("onBattleEnd",self,"r")

func r(win):
	for i in  sys.batScene.getAllChas() :
		if i.team == sys.player.team :
			i.plusHp(i.maxHp * lvPer(lv,0.09))
