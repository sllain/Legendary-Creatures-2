extends Skill

func _data():
	name = "飞沙走石"
	cd = 0
	tab = "专属"
func getDec():
	return tr("通常普攻时额外对2个敌人造成%d%%的物理伤害，触发攻击特效") % [per(50)]

func r(cha):
	hurtPer(cha,per(0.5),HURTTYPE.PHY,ATKTYPE.NORMAL)

func _in():
	masCha.connect("onNormAtk",self,"_rA")
	
func _rA():
	var chas = masCha.getMinRanChas(1,3)
	for i in chas:
		if i != masCha.aiCha :
			var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
			eff.get_node("up/img").frame = 3
			eff.flyToChara(i,500)
			eff.connect("onReach",self,"r",[i])
