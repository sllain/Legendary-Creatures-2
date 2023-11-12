extends Skill

func _data():
	name = "火元素"
	cd = 0
	tab = "火法"

func _in():
	sys.game.connect("onBattleStart",self,"r")
	
func r():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var cha:Chara= masCha.summ("c_5_2_2")
	cha.lv = lv
	var att = Att.new()
	cha.addAtt(att)
	for i in cons.upAtt:
		att.perMul(i,masCha.matk * 0.01 * per(1.5))
	
func getDec():
	return tr("召唤一个%d级的火元素，攻击能够附加烧灼，每100点魔法攻击提升%d%%的属性") % [lv,150]

