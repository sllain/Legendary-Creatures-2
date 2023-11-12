extends Skill

func _data():
	name = "飞锤"
	cd = 9
	tab = "钝器使"
	
func getDec():
	return tr("对最远3个敌人造成%d%%的物理伤害,附加目标10%%最大生命值的伤害和%d层破甲") % [lvPer(lv,1.5) * 100,per(10)]

func _cast():
	mas.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
		
	var chas = []
	for i in scene.getAllChas():
		if i.team != masCha.team:
			chas.append(i)
	chas.sort_custom(self,"sort")
	for i in 3 :
		if i >= chas.size() : break
		var cha = chas[i]
		var eff:Eff = mas.scene.newEff("e_feiChui",mas.position,mas.imgCenterPos)
		eff.flyToChara(cha, 300)
		eff.connect("onReach",self,"r",[cha])

func sort(a,b):
	if masCha.distanceTo(a) > masCha.distanceTo(b) :
		return true
	return false
	
func r(cha):
	hurt(cha,masCha.atk * per(1.5) + cha.maxHp * 0.1)
	masCha.castBuff(cha,"b_b_poJia",per(10))

