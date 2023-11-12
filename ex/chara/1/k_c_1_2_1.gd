extends Skill

func _data():
	name = "分裂"
	cd = 0
	tab = "专属"

func getDec():
	return tr("每承受%d%%的生命值的伤害分裂一个自身，分身减少%d%% 的增伤和减伤，最多分裂%d次") % [40,lvPer(lv,60,-lvPerVal),3]

var bval = 0
var fn = 0
func _in():
	bval = 0
	masCha.connect("onHurt",self,"r")
	fn = 0
	
func r(atkInfo):
	if fn >= 3 :return
	bval += atkInfo.finalVal 
	if bval >= masCha.maxHp * 0.4:
		var cha :Chara= masCha.summCopy(masCha,null,lvPer(lv,60,-lvPerVal))
		cha.hp = masCha.hp
		cha.plusHp(0)
		cha.delIdAff(id)
		bval = 0
		fn += 1
