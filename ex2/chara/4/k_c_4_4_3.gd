extends Skill

func _data():
	name = "兵行诡道"
	cd = 0
	tab = "专属"

func getDec():
	return tr("施放主动技能时获得%d层隐身，普通攻击减少一半隐身层数，每5层隐身使该次攻击额外造成%d%%的物理伤害") % [per(15),per(130)]

func _in():
	masCha.connect("onCastSkill",self,"r")
	masCha.connect("onCastHurtStart",self,"r2")
	
func r(skill):
	masCha.castBuff(masCha,"b_a_yinShen",per(15))
	
func r2(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL :
		var bf = masCha.hasAff("b_a_yinShen")
		if bf != null && bf.lv > 0:
			var eff = mas.scene.newEff("e_siJiErDong",masCha.position,masCha.imgCenterPos)
			eff.scale = Vector2(0.8,0.8)
			eff.modulate = Color("#00e6ff")
			yield(ctime(0.1),"timeout")
			var plv = bf.lv * 0.5
			hurtPerP(atkInfo.cha,plv * 0.2 * per(1.3))
			bf.lv -= plv
