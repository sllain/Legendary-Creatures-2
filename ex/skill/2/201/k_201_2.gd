extends Skill

func _data():
	name = "蓄力射击"
	cd = 6
	tab = "弓手"
	
func getDec():
	return tr("对目标造成%d%%的物理伤害，附加%d层破甲,可以暴击且攻速提高该技能施放速度") % [per(2.0) * 100,per(15)]

func _cast():
	mas.playAnim("atk2",masCha.spd)
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var cha = masCha.aiCha
	if cha != null:
		var eff:Eff = mas.scene.newEff("e_chuanTouJian",mas.position,mas.imgCenterPos)
		eff.flyToChara(cha, 500)
		eff.connect("onReach",self,"r",[cha])

func r(cha):
	var atkInfo = masCha.newAtkInfo(cha,masCha.atk * per(2.0),HURTTYPE.PHY,ATKTYPE.SKILL,self)
	
	atkInfo.canCri = true
	masCha.hurtBase(atkInfo)
	masCha.castBuff(cha,"b_b_poJia",per(15))
