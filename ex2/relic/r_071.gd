extends Relic

func _data():
	name = "棒槌"
	lock = 0
	
func getDec():
	return tr("战斗开始时使所有敌军附加%d层眩晕") % [lvPer(lv,3)]

func _in():
	sys.game.connect("onBattleStart",self,"r")
	
	
func r():
	var chas = sys.batScene.getAllChas()
	for i in chas:
		if i.team != sys.player.team:
			i.castBuff(i,"b_b_xuanYun",lvPer(lv,3))
