extends Eqp

func _data():
	name = "誓约之剑"
	isOnly = true
	var ds = {
		atk = 3,
		def = 1,
		mdef = 1,
	}
	attRatio(ds)
	lv = 5
	tab = "国王"

	dec = tr("开战时使周围1格友军获得%d层狂怒，而你获得%d%% 他们总和的物理攻击，持续到战斗结束") % [10,15]

func _in():
	sys.game.connect("onBattleStart",self,"r")
	self.atk = 0
	
func r():
	var atkn = 0
	for i in masCha.scene.getCellChas(masCha.cell) :
		masCha.castBuff(i,"b_a_kuangNu",10)
		atkn += i.atk * 0.15
	self.atk = atkn
