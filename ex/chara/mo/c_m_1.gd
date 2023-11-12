extends Chara

func _data():
	name = "魔王"
	tab = "战士 剑士"
	animFile = "res://res/anim/mo/1.tres"
	typeRotio(1)
	skillIds = ["k_c_m_1"]
	animOffset = Vector2(0,40)
	animScale = Vector2(1.1,1.1)
	lock = -1
	origin = "魔族"

var rb = false
func _in():
	if sys.game.diffLv >= 10 || sys.game.mode == "tower":
		rb = false
		connect("onDeathStart",self,"_r")
		
func _r(atkInfo):
	if rb :return
	rb = true
	animOffset = Vector2(0,15)
	animScale = Vector2(1.2,1.2)
	self.animFile = "res://res/anim/mo/1x.tres"
	upAnim()
	revive()
	hp = maxHp
	plusWard(maxHp)
	var k = data.newBase("k_c_m_1x")
	k.lv = lv - 2
	skills.addItem(k)
	for i in ["c_m_2","c_m_5","c_m_6"]:
		var cha = summ(i,Vector2(9,3))
		cha.isBoss = true
		cha.addRndItem(clamp(cha.lv-1,1,5))
		cha.addRndItem(clamp(cha.lv-1,1,5))
		cha.castBuff(cha,"b_a_boss",2)
		for j in lv -1:
			cha.aiPlusLv() 
		for j in cha.skills.items:
			j.lv = cha.lv - 2
		if sys.game.diffLv >=  6:
			cha.castBuff(cha,"b_a_moJun",1)
		cha.upAnim()

func del():
	.del()
	animFile = "res://res/anim/mo/1.tres"
	animOffset = Vector2(0,40)
	animScale = Vector2(1.1,1.1)
	upAnim()
	var k = skills.hasIdItem("k_c_m_1x")
	if k != null: skills.delItem(k)
