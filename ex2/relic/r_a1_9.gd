extends Relic

func _data():
	name = "震威"
	
func getDec():
	return tr("战士的技能造成伤害时，附加目标%d%%最大生命值的物理伤害") % [lvPer(lv,10)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.castCha.hasTab("战士") and atkInfo.atkType == ATKTYPE.SKILL :
		atkInfo.castCha.hurt(atkInfo.cha,lvPer(lv,0.1) * atkInfo.cha.maxHp,HURTTYPE.PHY,ATKTYPE.EFF,self)
