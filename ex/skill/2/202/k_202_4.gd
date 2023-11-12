extends Skill

func _data():
	name = "多重投射"
	cd = 7
	tab = "飞刺兽"
	
func getDec():
	return tr("对最近3个敌人造成%d%%的物理伤害，触发普攻特效，攻速会提高施放速度，每次普攻减少%d%%的冷却") % [per(1.4) * 90,20]

func _cast():
	mas.playAnim("atk2",masCha.spd)
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3/masCha.spd),"timeout")
	for cha in masCha.getMinRanChas(1,3):
		if cha != null && cha.team != masCha.team:
			var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
			eff.get_node("up/img").frame = 3
			eff.flyToChara(cha,300)
			eff.connect("onReach",self,"r",[cha])


func r(cha):
	hurtPer(cha,per(1.4),HURTTYPE.PHY,ATKTYPE.NORMAL)

func _in():
	masCha.connect("onNormAtk",self,"r2")

func r2():
	cdVal += cdVal * 0.2
