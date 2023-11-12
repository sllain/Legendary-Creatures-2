extends Skill

func _data():
	name = "疾风斩"
	cd = 7
	tab = "侠客"

func getDec():
	return tr("对目标1格敌人造成%d%%物理伤害，触发攻击特效") % [per(1.5)*100]

func _cast():
	if masCha.aiCha == null:return
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
	var eff = mas.scene.newEff("e_jiFengZhan",masCha.aiCha.position, masCha.aiCha.imgCenterPos)
	yield(ctime(0.2),"timeout")
	var chas = sys.batScene.getCellChas(masCha.aiCha.cell,1)
	for i in chas:
		if i == null : continue
		if i.team == masCha.team :continue
		hurtPer(i,per(1.5),HURTTYPE.PHY,ATKTYPE.NORMAL)
