extends Skill

func _data():
	name = "闪电链"
	cd = 9
	tab = "雷法"
	
var times = 0

func getDec():
	return tr("召唤闪电在敌方弹射%d次，每次造成%d%%魔法伤害，附加%d层麻痹") % [per(5),100,10]

func _cast():
	var n = lvPer(lv,5)
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
	var ocha = masCha
	for cha in masCha.getMinRanChas(1,n):
		if cha.team != masCha.team :
			var distance = ocha.distanceTo(cha)
			var eff:Eff = mas.scene.newEff("e_shanDianLian2",ocha.position, Vector2(0, -10))
			eff.flyToChara(cha, 0.1)
			eff.scale.x = distance
			hurtPerM(cha,1.0)
			masCha.castBuff(cha,"b_b_maBi",per(10))
			ocha = cha
			yield(ctime(0.2),"timeout")
	

