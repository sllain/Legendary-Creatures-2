extends Skill

func _data():
	name = "多重燃烧弹"
	cd = 10
	tab = "火枪手"

func getDec():
	return tr("对随机6名敌人造成%d%%的物理伤害，附加%d层烧灼，视为普攻") % [per(1.1)*100,per(10)]

func _cast():
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
	var chas = sys.batScene.getAllChas()
	chas.shuffle()
	var num = 0
	for i in chas:
		if i == null : continue
		if i.team == masCha.team :continue
		num += 1
		var eff:Eff = mas.scene.newEff("e_ranShaoDan",mas.position,mas.imgCenterPos)
		eff.flyToChara(i, 480)
		eff.connect("onReach",self,"r",[i])
		if num >= 6:break

func r(cha):
	hurtPer(cha,per(1.1),HURTTYPE.PHY,ATKTYPE.NORMAL)
	masCha.castBuff(cha,"b_b_shaoZhuo",per(10))

