extends Skill

func _data():
	name = "鲁莽挥击"
	cd = 8
	tab = "专属"
	
func getDec():
	return tr("造成3次%d%%的物理伤害，暴击率能够提高挥击次数") %  [per(100)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.08),"timeout")
	var eff = mas.scene.newEff("e_luMangHuiJi",masCha.aiCha.position,masCha.aiCha.imgCenterPos)
	yield(ctime(0.1),"timeout")
	for i in max(3 * (1 + masCha.cri),3) :
		hurtPer(masCha.aiCha,per(1.0))
		yield(ctime(0.1),"timeout")
