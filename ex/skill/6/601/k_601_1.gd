extends Skill

func _data():
	name = "暗影飞弹"
	cd = 0
	tab = "牧师"

func getDec():
	return tr("施放治疗时对随机敌方造成%d%%该值的魔法伤害,不为技能伤害") % per(50)

func _in():
	masCha.connect("onCastPlus",self,"r")

func r(info):
	var cs = []
	for cha in sys.batScene.getAllChas():
		if cha.team != masCha.team && cha.isDeath == false:
			cs.append(cha)
	var c :Chara= rndListItem(cs)
	if c == null: return
	var eff = scene.newEff("e_xianXueFeiDan", masCha.position,masCha.imgCenterPos)
	eff.flyToChara(c, 400)
	eff.connect("onReach",self,"r2",[c,info.finalVal * per(0.5)])

func r2(c,val):
	hurt(c,val,HURTTYPE.MAG,ATKTYPE.EFF)

