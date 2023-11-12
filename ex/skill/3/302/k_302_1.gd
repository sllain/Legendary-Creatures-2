extends Skill

func _data():
	name = "反伤甲"
	cd = 0
	tab = "重甲士"
	
func getDec():
	return tr("对他造成伤害的单位会受到反伤，普攻攻击者受到%d%%的物理防御的魔法伤害，技能攻击者受到%d%%的魔法防御的魔法伤害") %  [per(0.3) * 100,per(1.2) * 100]

func _in():
	masCha.connect("onHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL :
		var cha = atkInfo.castCha
		if cha != null && cha.team != masCha.team:
			var eff:Eff = scene.newEff("e_atk1",masCha.position,masCha.imgCenterPos)
			eff.flyToChara(cha,600)
			eff.connect("onReach",self,"r2",[cha])
	elif atkInfo.atkType == ATKTYPE.SKILL :
		var cha = atkInfo.castCha
		if cha != null && cha.team != masCha.team:
			var eff:Eff = scene.newEff("e_atk1",masCha.position,masCha.imgCenterPos)
			eff.flyToChara(cha,600)
			eff.connect("onReach",self,"r3",[cha])

func r2(cha):
	hurt(cha,per(0.3) * masCha.def,HURTTYPE.PHY,ATKTYPE.EFF)

func r3(cha):
	hurt(cha,per(1.2) * masCha.mdef,HURTTYPE.PHY,ATKTYPE.EFF)
