extends Skill

func _data():
	name = "高压激荡"
	cd = 0
	tab = "专属"
	
func getDec():
	return tr("+%d%%对技能的减伤，并且受到技能伤害时%d%%的几率对周围一格单位造成%d%%的物理伤害附加%d层麻痹") % [per(20),40,per(100),per(10)]

func _in():
	masCha.connect("onHurtStart",self,"r")
	
func r(info):
	if info.atkType == ATKTYPE.SKILL:
		info.per -= per(0.2)
		if rndPer(0.4) :
			var eff = mas.scene.newEff("e_leiZhen",masCha.position,masCha.imgCenterPos)
			var chas = sys.batScene.getCellChas(masCha.cell,1)
			if chas.size() == 0:return
			for i in chas:
				if i == null : continue
				if i.team == masCha.team : continue
				hurtPerP(i,per(1.0),ATKTYPE.EFF)
				masCha.castBuff(i,"b_b_maBi",per(10))
