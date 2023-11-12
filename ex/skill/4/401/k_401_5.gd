extends Skill

func _data():
	name = "放血"
	cd = 5
	tab = "忍者"
	
func getDec():
	return tr("造成%d%%物理伤害，附加%d层流血") %  [per(2.2) * 100,per(10)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_ziSeZhuaJi", mas.aiCha.position, mas.aiCha.imgCenterPos)
	yield(ctime(0.1),"timeout")
	hurtPer(masCha.aiCha, per(2.2))
	masCha.castBuff(masCha.aiCha,"b_b_liuXue",per(10))
