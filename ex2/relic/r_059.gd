extends Relic

func _data():
	name = "收割者"
	lock = 0
	
func getDec():
	return tr("本场战斗中我方单位在击杀时，获得%d%%攻击力和法强") % [lvPer(lv,5)]

func _in():
	sys.game.connect("onChaKill",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team :
		var att = Att.new()
		atkInfo.castCha.addAtt(att)
		att.perAdd("atk",lv * 0.05)
		att.perAdd("matk",lv * 0.05)
