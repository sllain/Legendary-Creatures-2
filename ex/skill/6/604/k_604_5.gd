extends Skill

func _data():
	name = "元素失控"
	cd = 0
	tab = "炼金术士"
	
func getDec():
	return tr("当我方对敌方附加负面状态时，%d%%的几率召唤飞弹追击造成%d%%的魔法伤害，并使负面状态额外增加%d层") % [40,per(50),per(5)]

func _in():
	sys.game.connect("onChaCastBuff",self,"_r")
	
func _r(buff):
	var c = buff.masCha
	if c.team == sys.player.team :return
	if c != null && buff.castCha.team == masCha.team && rndPer(0.4) &&  buff.hasTab("deBuff"):
		var eff = scene.newEff("e_atk1", masCha.position,masCha.imgCenterPos)
		eff.get_node("up/img").frame = 3
		eff.flyToChara(c, 500)
		eff.connect("onReach",self,"r2",[c])
		buff.plusLv += per(5)

func r2(c):
	hurtPerM(c,per(0.5),ATKTYPE.EFF)

