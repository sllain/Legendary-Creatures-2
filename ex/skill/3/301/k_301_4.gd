extends Skill

func _data():
	name = "盾反"
	cd = 0
	tab = "盾卫"

func _in():
	masCha.connect("onPlus",self,"r")
	
func r(info):
	if info.type == "ward":
		for cha in masCha.scene.getCellChas(masCha.cell) :
			if cha.team != mas.team :
				var eff:Eff = mas.scene.newEff("e_huoQiu",mas.position,mas.imgCenterPos)
				eff.flyToChara(cha,300)
				eff.connect("onReach",self,"r2",[cha,info.finalVal * per(0.8)])

func r2(cha,val):
	hurt(cha,val,HURTTYPE.PHY,ATKTYPE.EFF)

func getDec():
	return tr("获得护盾时，对周围1格敌方造成%d%%该护盾值的物理伤害") % [per(0.8) * 100]
