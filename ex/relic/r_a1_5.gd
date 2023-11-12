extends Relic

func _data():
	name = "可乘之隙"
	lock = 0
	
func getDec():
	return tr("战士对破甲的敌人伤害提高，每10层提高%d%%") % [lvPer(lv,10)]
	
func _in():
	sys.game.connect("onChaCastHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team and atkInfo.castCha.hasTab("战士"):
		var bf = atkInfo.cha.hasAff("b_b_poJia")
		if bf != null:
			atkInfo.per += max(int(bf.lv / 10),1)*lvPer(lv,0.1)
