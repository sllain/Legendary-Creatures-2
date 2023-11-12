extends Skill

func _data():
	name = "化学风暴"
	cd = 10
	tab = "炼金术士"
	
func getDec():
	return tr("使2格范围内的友军获得%d层随机增益状态，对敌人施加%d层随机负面状态") % [per(20),per(20)]

const bbfs = ["b_a_kuangNu","b_a_weiNeng","b_a_jiSu","b_a_chaoRan","b_a_diYu"]
const bbfs2 = ["b_b_liuXue","b_b_zhongDu","b_b_shaoZhuo","b_b_jieShuang","b_b_poJia","b_b_maBi"]

func _cast():
	mas.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var cell = sys.batScene.getEnemyCenterCell(masCha.team)
	var eff = masCha.scene.newEff("e_guiYiWuQi", sys.batScene.map_to_world(cell), Vector2(0, -20))
	eff.scale = Vector2(1.8, 1.8)
	for i in sys.batScene.getCellChas(cell,2):
		if i.team == masCha.team :
			masCha.castBuff(i,rndListItem(bbfs),per(20))
		else:
			masCha.castBuff(i,rndListItem(bbfs2),per(20))
