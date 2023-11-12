extends Skill

func _data():
	name = "地爆天星"
	cd = 10
	tab = "专属"
	lock = -1
func getDec():
	return tr("对周围1格敌人造成%d%%目标最大生命值的真实伤害，附加%d层5种不同的负面状态") %  [per(20),per(10)]

const bbfs = ["b_a_kuangNu","b_a_weiNeng","b_a_jiSu","b_a_chaoRan","b_a_diYu"]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_hangDi", mas.position,mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	for i in masCha.scene.getCellChas(masCha.cell):
		if i.team != masCha.team :
			var eff2 = masCha.scene.newEff("e_shanYingGeHou",i.position, i.imgCenterPos)
			hurt(i,i.maxHp * per(0.2),HURTTYPE.REAL)
			for j in bbfs:
				masCha.castBuff(i,j,per(10))
	
