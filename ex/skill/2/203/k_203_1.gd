extends Skill

func _data():
	name = "溅射弹药"
	cd = 0
	tab = "火枪手"
	perAdd("atk",0.5)
	perAdd("spd",-0.5)

func getDec():
	return tr("攻击提升50%%，攻速减少50%%，普攻命中时，对周围单位造成%d%%的物理伤害，可暴击") % [per(0.3)*100]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
var nusm = 0
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL and atkInfo.finalVal != 0:
		nusm += 1
		var chas = sys.batScene.getCellChas(atkInfo.cha.cell,1)
		for i in chas:
			if i == null : continue
			if i.team == masCha.team or i == atkInfo.cha: continue
			var info = {castCha=masCha,cha=i,val=per(0.3)*masCha.atk,source=masCha,atkType=ATKTYPE.SKILL,hurtType=HURTTYPE.PHY,per=1.0,finalPer = 1.0,finalVal=0,canCri=true,isCri=false}
			masCha.hurtBase(info)

