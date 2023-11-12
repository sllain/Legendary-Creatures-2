extends Skill

func _data():
	name = "精准制导"
	cd = 8
	tab = "火枪手"

func getDec():
	return tr("对距离最远的目标造成%d%%的物理伤害，目标每种异常状态使伤害提高%d%%") % [per(1.5)*100,20]

func _cast():
	var cha = null
	for i in sys.batScene.getAllChas() :
		if i == null : continue
		if i.team == masCha.team:continue
		if cha == null :
			cha = i
			continue
		if masCha.distanceTo(i) > masCha.distanceTo(cha) :
			cha = i
	if cha != null:
		mas.playAnim("buff")
		yield(ctime(0.3),"timeout")
		var eff = mas.scene.newEff("e_paiJiPao",cha.position,cha.imgCenterPos)
		yield(ctime(0.1),"timeout")
		var n = 1
		for i in cha.affs:
			if i.get("deBuff") == true:n += 1
		hurtPer(cha,per(1.5) * lvPer(n,1,0.2))
