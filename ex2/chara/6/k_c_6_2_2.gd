extends Skill

func _data():
	name = "超度"
	cd = 0
	tab = "专属"

func getDec():
	return tr("每个敌人死亡，使最虚弱友方恢复%d%%魔法攻击的生命值，且有%d%%概率获得%d魂") % [per(1.5 * 100),25,per(5)]

func _in():
	sys.game.connect("onChaDeath",self,"rDeath")
	
func rDeath(atkInfo):
	if atkInfo.cha.team != sys.player.team:
		var xcha = masCha.getWeakCha(2)
		if xcha != null	:
			var eff = mas.scene.newEff("e_zhiLiaoShu", xcha.position, xcha.imgCenterPos)
			yield(ctime(0.1),"timeout")
			plusHp(per(masCha.matk * 1.5),xcha)
		if rndPer(0.25) :
			sys.player.items.addItem(data.newBase("m_xp").setNum(per(5)))

