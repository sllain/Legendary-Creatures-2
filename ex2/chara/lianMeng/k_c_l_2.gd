extends Skill

func _data():
	name = "裂甲圣弹"
	cd = 7
	tab = "专属"
func getDec():
	return tr("对血量最高的单位造成%d%%的物理伤害，如果目标生命值大于%d%%，则为真实伤害") % [per(1.9) * 100,70]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var cha = masCha.getMaxHpCha()
	if cha != null:
		var eff = mas.scene.newEff("e_lieJiaShengDan",cha.position,cha.imgCenterPos)
		if cha.hp / cha.maxHp > 0.7:
			hurt(cha,masCha.atk * per(1.9),HURTTYPE.REAL)
		else:
			hurtPerP(cha,per(1.9))
