extends Skill

func _data():
	name = "连发弩"
	cd = 7
	tab = "弩手"

func getDec():
	return tr("快速射出%d发箭矢，每发造成%d%%的真实伤害，身上每%d层急速，额外射出1发") % [3,per(50),5]

func _cast():
	mas.playAnim("atk2",masCha.spd)
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3/masCha.spd),"timeout")
	var n = 3
	var bf = masCha.hasAff("b_a_jiSu")
	if bf != null : n += bf.lv / 5
	for i in n:
		var cha = masCha.aiCha
		if cha != null && cha.team != masCha.team:
			var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
			eff.get_node("up/img").frame = 3
			eff.flyToChara(cha,800)
			eff.connect("onReach",self,"r",[cha])
			yield(ctime(0.1),"timeout")

func r(cha):
	hurtPer(cha,per(0.5),HURTTYPE.REAL,ATKTYPE.EFF)

 
