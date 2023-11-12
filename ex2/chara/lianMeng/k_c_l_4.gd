extends Skill

func _data():
	name = "极影斩"
	cd = 4
	tab = "专属"
func getDec():
	return tr("对目标造成%d次%d%%的物理伤害，触发普攻特效") % [per(5),25]

func _cast():
	if masCha.aiCha == null:return
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
	var eff = mas.scene.newEff("e_jiYingZhan",masCha.aiCha.position, masCha.aiCha.imgCenterPos)
	eff.modulate = Color("#da29ff")
	eff.scale = Vector2(0.6,0.6)
	for i in per(5):
		hurtPerP(masCha.aiCha,per(0.25),ATKTYPE.NORMAL)
			
