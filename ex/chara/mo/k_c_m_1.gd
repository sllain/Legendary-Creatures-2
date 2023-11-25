extends Skill

func _data():
	name = "噬魂斩"
	cd = 8
	tab = "专属"
	lock = -1
	
func getDec():
	return tr("对周围1格敌人造成%d%%目标最大生命值的物理伤害，获得%d层5种不同的增益状态，回复%d%%物理攻击的生命值和护盾值") %  [per(30),per(15),50]

const bbfs = ["b_a_kuangNu","b_a_weiNeng","b_a_jiSu","b_a_chaoRan","b_a_diYu"]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_xuanFengZhan", mas.position,mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	for i in masCha.scene.getCellChas(masCha.cell):
		if i.team != masCha.team :
			var eff2 = masCha.scene.newEff("e_shanYingGeHou",i.position, i.imgCenterPos)
			hurt(i,i.maxHp * per(0.3))
	for i in bbfs:
		masCha.castBuff(masCha,i,per(15))
	var h = masCha.atk * 0.5
	plusHp(h)
	plusWard(h)


