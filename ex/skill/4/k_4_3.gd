extends Skill

func _data():
	name = "暗杀"
	cd = 6
	tab = "刺客"

func getDec():
	return tr("闪现至血量最低敌方旁，造成%d%%的物理伤害") % per(160)

func _cast():
	var cha = masCha.getMinHpCha(1)
	if cha != null:
		var cell = cha.cell
		masCha.matMoveUp(cell)
		masCha.aiCha = null
		mas.playAnim("atk2")
		#mas.playSe("res://res/se/HeavySword4.wav")
		yield(ctime(0.2),"timeout")
		if cha != null && masCha.aiCha != null:
			var eff = mas.scene.newEff("e_shanYingGeHou",masCha.aiCha.position, mas.imgCenterPos)
			hurtPer(cha,per(1.6))
		
