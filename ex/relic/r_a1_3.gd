extends Relic

func _data():
	name = "扒皮拆骨"
	
func getDec():
	return tr("战士造成伤害时，额外附加%d%%物理攻击的真实伤害") % [lvPer(lv,20)]
	
func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.atkType != ATKTYPE.EFF && atkInfo.castCha.hasTab("战士"):
		atkInfo.castCha.hurt(atkInfo.cha,lvPer(lv,0.20) * atkInfo.castCha.atk,HURTTYPE.REAL,ATKTYPE.EFF,self)
