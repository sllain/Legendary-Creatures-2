extends Skill

func _data():
	name = "粉碎"
	cd = 6
	tab = "钝器使"
	
func getDec():
	return tr("造成%d%%物理伤害，附加%d层眩晕，%d层破甲") %  [lvPer(lv,2.0) * 100,per(5),per(10)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var eff = mas.scene.newEff("e_fenSui",masCha.aiCha.position, mas.imgCenterPos)

	hurtPer(masCha.aiCha,per(2.0))
	masCha.castBuff(masCha.aiCha,"b_b_poJia",per(10))
	masCha.castBuff(masCha.aiCha,"b_b_xuanYun",per(5))
