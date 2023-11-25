extends Skill

func _data():
	name = "医疗波"
	cd = 12
	tab = "牧师"
	
func getDec():
	return tr("医疗波在友军中弹射%d次，每次恢复目标5%%的生命值") % [per(6)]

var n = 0
func _cast():
	n = lvPer(lv,5)
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	d(masCha)
	
func d(ocha):
	if n <= 0 :return
	var ls = ocha.getMinRanChas(2,2)
	if ls.size() > 0 :
		var cha = ls[0]
		if cha != null:
			var distance = ocha.distanceTo(cha)
			var eff:Eff = mas.scene.newEff("e_zhiLiaoBo",ocha.position, Vector2(0, -10))
			eff.flyToChara(cha, 0.1)
			eff.scale.x = distance
			n -= 1
			plusHp(per(0.06) * cha.maxHp,cha)
			yield(ctime(0.2),"timeout")
			if is_instance_valid(scene) == false :return
			d(cha)
