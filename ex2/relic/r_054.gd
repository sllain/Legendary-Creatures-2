extends Relic

var tm = 0

func _data():
	name = "复生"
	lock = 0
	
func getDec():
	return tr("战斗时，我方非召唤单位死亡，则复活并回复%d%%生命值，每场战斗仅能触发%d次") % [50,lv]

func _in():
	sys.game.connect("onChaDeathStart",self,"r")
	sys.game.connect("onBattleStart",self,"reset")

func reset():
	tm = lv

func r(atkInfo):
	if atkInfo.cha.isDeath && atkInfo.cha.team == sys.player.team and atkInfo.cha.isSummon == false and tm > 0:
		atkInfo.cha.revive(false)
		atkInfo.cha.plusHp(atkInfo.cha.maxHp*0.5)
		tm -= 1
	
