extends Skill

func _data():
	name = "光芒点射"
	cd = 0
	tab = "弩手"

func getDec():
	return tr("获得急速时，每%d层急速便射出一发箭矢对目标造成%d%%的真实伤害") % [5,per(80)]

func _in():
	masCha.connect("onAddBuff",self,"_r")
	
func _r(buff):
	if buff.id == "b_a_jiSu" && buff.plusLv >= 5 :
		for i in buff.plusLv / 5:
			var cha = masCha.aiCha
			if cha != null && cha.team != masCha.team:
				var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
				eff.get_node("up/img").frame = 3
				eff.flyToChara(cha,800)
				eff.connect("onReach",self,"r",[cha])
				yield(ctime(0.1),"timeout")

func r(cha):
	hurtPer(cha,per(0.8),HURTTYPE.REAL,ATKTYPE.EFF)

