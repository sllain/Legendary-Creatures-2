extends Relic

var ar = []

func _data():
	name = "狼群"
	lock = 0
	
func getDec():
	return tr("战斗开始时，每有一名非召唤友军，全队增伤+%d%%") % [lvPer(lv,3)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"r")
	sys.game.connect("onBattleStart",self,"reset")
	
func reset():
	ar.clear()
	var chas = sys.batScene.getAllChas()
	for i in chas:
		if i.team == sys.player.team and not i.isSummon:
			ar.append(i)
	
func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team:
		atkInfo.per += ar.size() * lvPer(lv,0.03)
