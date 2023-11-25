extends Skill

var dmg = 0

func _data():
	name = "神圣震击"
	cd = 7
	tab = "圣骑士"
	
func getDec():
	return tr("对目标造成%d%%圣骑士最大生命值的魔法伤害，并使最虚弱友军获得该伤害值的护盾") %  [per(0.3)*100]

func _cast():
	if masCha.aiCha == null:return
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
	var baoZhaEff = mas.scene.newEff("e_baoZha1",masCha.aiCha.position,masCha.aiCha.imgCenterPos)
	yield(ctime(0.1),"timeout")
	var info = hurt(masCha.aiCha,masCha.maxHp * per(0.3),HURTTYPE.MAG)
	var cha = masCha.getWeakCha(2)
	if cha != null && info != null:
		plusWard(info.finalVal,cha)

