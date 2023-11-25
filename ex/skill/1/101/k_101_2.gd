extends Skill

func _data():
	name = "重劈"
	cd = 5
	tab = "剑士"
	
func getDec():
	return tr("造成%d%%物理伤害，附加%d层流血，目标每5层流血使你获得%d%%物理攻击的护盾") %  [per(2.0) * 100,per(15),per(50)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_zhongPi",masCha.aiCha.position, mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	hurtPer(masCha.aiCha,per(2.0))
	var buff = masCha.castBuff(masCha.aiCha,"b_b_liuXue",per(15))
	if buff == null:return
	plusWard(masCha.atk * per(0.5) * buff.lv * 0.2)
