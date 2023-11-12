extends Relic

func _data():
	name = "无畏之势"
	
func getDec():
	return tr("战斗开始时，全队获得%d%% 护盾值") % [lvPer(lv,8)]
	
func _in():
	sys.game.connect("onBattleStart",self,"r")

func r():
	for i in  sys.batScene.getAllChas() :
		if i.team == sys.player.team :
			i.plusWard(i.maxHp * lvPer(lv,0.08))
