extends Skill

func _data():
	name = "身外化身"
	cd = 0
	tab = "专属"
func getDec():
	return tr("开战时在前方召唤%d个分身，只要本体存活分身死亡时就会重新召唤，分身减少%d%%的增伤和减伤") % [2,lvPer(lv,50,-lvPerVal)]
	
func _in():
	sys.game.connect("onBattleStart",self,"_bs")
	
func _bs():
	for i in 2 :r()
	
func r():
	if masCha.isSummon :return
	var cha :Chara= masCha.summCopy(masCha,masCha.cell + Vector2(masCha.dire,0),lvPer(lv,50,-lvPerVal))
	cha.hp = masCha.hp
	cha.plusHp(0)
	
	cha.connect("onDeath",self,"r2")

func r2(info):
	yield(ctime(0.5),"timeout")
	if masCha.isDeath == false && is_instance_valid(scene) :
		r()
