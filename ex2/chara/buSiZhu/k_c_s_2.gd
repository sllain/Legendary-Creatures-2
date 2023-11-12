extends Skill

func _data():
	name = "爆裂射击"
	cd = 6
	tab = "专属"	
func getDec():
	return tr("对最近3个敌人造成%d%%的物理伤害，暴击率可以提升伤害，施法速度随攻速提高") % [per(1.0) * 100]

func _cast():
	mas.playAnim("atk2",masCha.spd)
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3 / masCha.spd),"timeout")
	var n = 1
	for i in 4:
		for j in scene.getRing(masCha.cell,i) :
			var cha = scene.matObj(j)
			if cha != null && cha.team != masCha.team:
				var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
				eff.get_node("up/img").frame = 3
				eff.flyToChara(cha,300)
				eff.connect("onReach",self,"r",[cha])
				n += 1
				if n >= 3 :
					break

func r(cha):
	hurtPer(cha,per(1.0) * (1 + masCha.cri))
