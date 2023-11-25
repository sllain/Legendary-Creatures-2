extends Skill

func _data():
	name = "治疗术"
	cd = 6
	tab = "辅助"
	
func getDec():
	return tr("使最虚弱友军回复%d%%魔法攻击的生命值") % [per(1.7) * 100]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var xcha = masCha.getWeakCha(2)
	if xcha != null	:
		var eff = mas.scene.newEff("e_zhiLiaoShu", xcha.position, xcha.imgCenterPos)
		yield(ctime(0.1),"timeout")
		plusHp(per(masCha.matk * 1.7),xcha)
