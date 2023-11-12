extends Skill

func _data():
	name = "暗影突袭"
	cd = 6
	tab = "暗杀者"
	
func getDec():
	return tr("对目标造成%d%%的物理伤害，隐身期间对3个单位造成伤害") %  [per(1.8)*100]

func _cast():
	masCha.playAnim("atk2")
	if masCha.yingTime > 0:
		var chas = masCha.getMinRanChas(1,3)
		for i in chas:
			var eff = mas.scene.newEff("e_anYingTuXi",i.position, i.imgCenterPos)

			hurtPer(i,per(1.5),HURTTYPE.PHY,ATKTYPE.SKILL)
			
	elif masCha.aiCha != null:
		var eff = mas.scene.newEff("e_anYingTuXi",masCha.aiCha.position, masCha.aiCha.imgCenterPos)

		hurtPer(masCha.aiCha,per(1.8),HURTTYPE.PHY,ATKTYPE.SKILL)
