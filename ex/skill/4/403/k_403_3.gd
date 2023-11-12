extends Skill

func _data():
	name = "风袭"
	cd = 0
	tab = "侠客"

func getDec():
	return tr("击杀单位后，闪现至血量最低敌人造成%d次%d%%的物理伤害，触发攻击特效") % [2,per(80)]

func _in():
	masCha.connect("onKill",self,"r")

func r(atkInfo):
	mas.playAnim("atk2")
	yield(ctime(0.25),"timeout")
	var cha = masCha.getMinHpCha()
	if cha == null:return
	masCha.matMoveUp(cha.cell)
	masCha.aiCha = cha
	var eff = mas.scene.newEff("e_fengXi",cha.position, cha.imgCenterPos)
	for i in 2:
		hurtPer(masCha.aiCha,per(0.8),HURTTYPE.PHY,ATKTYPE.NORMAL)
		yield(ctime(0.04),"timeout")



