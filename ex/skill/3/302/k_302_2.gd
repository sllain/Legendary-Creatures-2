extends Skill

func _data():
	name = "臂铠重击"
	cd = 6
	tab = "重甲士"
	self.def = 0.0
	self.mdef = 0.0
	
func getDec():
	return tr("对目标造成%d%%物理防御+魔法防御的魔法伤害，获取目标%d%%双抗，最高%d点，战斗结束重置") %  [per(1.0) * 100,p * 100,per(mp)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var cha = masCha.aiCha
	if cha != null && cha.team != masCha.team:
		var eff:Eff = mas.scene.newEff("e_duDang",mas.position,mas.imgCenterPos)
		eff.flyToChara(cha,300)
		eff.connect("onReach",self,"r",[cha])
var p = 0.1
var mp = 300
func r(cha):
	hurt(cha,per(1.0) * masCha.mdef + per(1.0) * masCha.def,HURTTYPE.MAG)
	var d1 = cha.def * p
	var d2 = cha.mdef * p
	if self.def < per(mp) :self.def += d1
	if self.mdef < per(mp) :self.mdef += d2
	
func _in():
	self.def = 0
	self.mdef = 0
