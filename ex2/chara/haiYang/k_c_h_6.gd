extends Skill

func _data():
	name = "水疗"
	cd = 9
	tab = "专属"

func getDec():
	return tr("最近%d个友军回复%d%%魔法攻击的生命值和%d层随机增益，目标每5层增益治疗效果提升%d%%") % [4,per(100),per(10),15]
	
const bbfs = ["b_a_kuangNu","b_a_weiNeng","b_a_jiSu","b_a_chaoRan","b_a_diYu"]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	for i in masCha.getMinRanChas(2,4):
		if i.team == masCha.team :
			masCha.castBuff(i,rndListItem(bbfs),per(10))
			var p = 1.0
			for j in i.affs:
				if j is Buff && j.hasTab("buff") && j.lv > 0:
					p += (j.lv / 5 ) * 0.15
			if p <= 0 :return
			masCha.plusHp(masCha.matk * per(1.0) * p,i)


