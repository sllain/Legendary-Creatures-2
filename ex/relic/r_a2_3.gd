extends Relic

func _data():
	name = "百步穿杨"
	
func getDec():
	return tr("射手的普攻伤害，会额外造成%d%%物理攻击的真实伤害") % [lvPer(lv,20)]

func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.atkType == ATKTYPE.NORMAL && atkInfo.castCha.hasTab("射手"):
		atkInfo.castCha.hurt(atkInfo.cha,lvPer(lv,0.2) * atkInfo.castCha.atk,HURTTYPE.REAL,ATKTYPE.EFF,self)
