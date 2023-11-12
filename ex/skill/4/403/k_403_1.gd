extends Skill

func _data():
	name = "连刃斩"
	cd = 0
	tab = "侠客"
	
func getDec():
	return tr("通常普攻时%d%%的几率附加一次强击造成%d%%的物理伤害，触发攻击特效") % [per(40),per(1.0)*100]


func _in():
	masCha.connect("onNormAtk",self,"r")
	
func r():
	if sys.rndPer(per(0.4)) && masCha.aiCha != null:
		var eff = mas.scene.newEff("e_qiangLi",masCha.aiCha.position,masCha.aiCha.imgCenterPos)
		hurtPerP(masCha.aiCha,per(1.0),ATKTYPE.NORMAL)
