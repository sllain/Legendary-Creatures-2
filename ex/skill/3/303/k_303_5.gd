extends Skill

var dmg = 0

func _data():
	name = "践踏"
	cd = 10
	tab = "肉霸"
	
func getDec():
	return tr("对周围1格造成自身%d%%最大生命值的物理伤害，附加%d层眩晕") %  [per(0.2)*100,per(5)]

func _cast():
	var chas = sys.batScene.getCellChas(masCha.cell,1)
	if chas.size() == 0:return
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
	var eff = mas.scene.newEff("e_hanDi",masCha.position,masCha.imgCenterPos)
	yield(ctime(0.1),"timeout")
	for i in chas:
		if i == null : continue
		if i.team == masCha.team : continue
		hurt(i,per(0.2)*masCha.maxHp)
		masCha.castBuff(i,"b_b_xuanYun",per(5))
