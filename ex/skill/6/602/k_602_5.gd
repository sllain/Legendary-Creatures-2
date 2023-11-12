extends Skill

func _data():
	name = "激流"
	cd = 10
	tab = "萨满"

func getDec():
	return tr("获取最近6名单位，如果是敌方造成%d%%的魔法伤害，如果是友方恢复%d%%的魔法攻击的生命值") % [per(150),per(130)]

func _cast():
	mas.playAnim("atk")
	yield(ctime(0.4),"timeout")
	for i in masCha.getMinRanChas(0,6):
		var eff = mas.scene.newEff("e_zhiLiaoShu", i.position, i.imgCenterPos)
		if i.team == mas.team:
			masCha.plusHp(masCha.matk * per(1.3),i)
		else:
			hurtPerM(i,per(1.5))
