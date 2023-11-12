extends Relic

func _data():
	name = "能抗能打"
	
func getDec():
	return tr("坦克造成伤害时附加他%d%%最大生命值的魔法伤害") % [lvPer(lv,5)]

func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.atkType != ATKTYPE.EFF && atkInfo.castCha.hasTab("坦克"):
		atkInfo.castCha.hurt(atkInfo.cha,lvPer(lv,0.05) * atkInfo.castCha.maxHp,HURTTYPE.MAG,ATKTYPE.EFF,self)
