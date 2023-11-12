extends Skill

func _data():
	name = "鲜血飞弹"
	cd = 10
	tab = "专属"
func getDec():
	return tr("施放5发鲜血飞弹攻击随机敌人，每发造成%d%%的魔法伤害，附加10层流血，冷却速度能够增加飞弹数量") % [per(0.35) * 100]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	for i in max(5 * masCha.cdSpd,5):
		var cs = []
		for cha in sys.batScene.getAllChas():
			if cha.team != masCha.team && cha.isDeath == false:
				cs.append(cha)
		var c :Chara= rndListItem(cs)
		if c == null: return
		var eff = scene.newEff("e_xianXueFeiDan", masCha.position, Vector2(0, -20))
		eff.flyToChara(c, 400)
		eff.connect("onReach",self,"r2",[c])
		yield(ctime(0.3),"timeout")

func r2(c):
	hurtPerM(c,per(0.35))
	masCha.castBuff(c,"b_b_liuXue",10)
