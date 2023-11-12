extends Skill

func _data():
	name = "唾液酸"
	cd = 0
	tab = "飞刺兽"

var n = 0
func _in():
	masCha.connect("onNormAtk",self,"r")
	n = 0
	
func r():
	n += 1
	if masCha.aiCha == null:return
	if n >= 3 :
		var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
		eff.get_node("up/img").frame = 3
		eff.flyToChara(masCha.aiCha,300)
		eff.connect("onReach",self,"r2",[masCha.aiCha])
		n = 0

func r2(cha):
	hurtPer(cha,per(1.3),HURTTYPE.PHY,ATKTYPE.NORMAL)

func getDec():
	return tr("每3次普通攻击额外附加一次强击造成%d%%的伤害，触发普攻特效") % [per(1.3) * 100]
