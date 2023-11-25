extends Skill

func _data():
	name = "大杀四方"
	cd = 9
	tab = "剑士"
	
func getDec():
	return tr("对周围1格造成%d%%物理伤害，目标每层流血提高%d%%的伤害，并回复%d%%该伤害的生命值") %  [per(1.6) * 100,4,70]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_xuanFengZhan", mas.position,mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	var p = 0.0
	for i in masCha.scene.getCellChas(mas.cell):
		if i.team != mas.team :
			var p2 = per(1.6)
			var bf = masCha.hasAff("b_b_liuXue") 
			if bf != null:
				p2 *= 1 + bf.lv * 0.04
			var info = hurtPer(i,p2)
			if info != null:
				p += info.finalVal
	plusHp(p * 0.7)
