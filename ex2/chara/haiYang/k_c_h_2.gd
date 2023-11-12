extends Skill

func _data():
	name = "水弹喷发"
	cd = 7
	tab = "专属"
func getDec():
	return tr("获得%d层急速，身上每有%d层急速便发射一颗水弹造成%d%%的真实伤害") % [per(15),5,per(0.5) * 100]
	
func _cast():
	mas.playAnim("atk")
	yield(ctime(0.3),"timeout")
	var buff = masCha.castBuff(masCha,"b_a_jiSu",per(15))
	for i in buff.lv / 5:
		var cha = masCha.aiCha
		if cha != null && cha.team != masCha.team:
			var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
			eff.get_node("up/img").frame = 3
			eff.flyToChara(cha,800)
			eff.connect("onReach",self,"r",[cha])
			yield(ctime(0.1),"timeout")

func r(cha):
	hurt(cha,masCha.atk * per(0.5),HURTTYPE.REAL,ATKTYPE.EFF)

