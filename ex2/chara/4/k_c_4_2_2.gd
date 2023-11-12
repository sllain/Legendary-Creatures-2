extends Skill

func _data():
	name = "凿击"
	cd = 3
	tab = "专属"

func getDec():
	return tr("造成%d%%的物理伤害附加%d层中毒和流血") % [per(60),per(5)]

func _cast():
	masCha.playAnim("atk1")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	if masCha.aiCha == null:return
	var eff = mas.scene.newEff("e_ziSeZhuaJi", mas.aiCha.position, mas.aiCha.imgCenterPos)
	masCha.castBuff(masCha.aiCha,"b_b_zhongDu",per(5))
	masCha.castBuff(masCha.aiCha,"b_b_liuXue",per(5))
	hurtPer(masCha.aiCha, per(0.6))
	
