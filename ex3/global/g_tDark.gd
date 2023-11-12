extends Global

func _data():
	name = "幽暗值"
	txt = "0"
	excMode = "map"
	icoId ="ico_g_dark"
	isVisIco = true
	lv = 0

var maxLv = 99

func setLv(val):
	.setLv(val)
	var s = tr("当前幽暗值%d") % lv + "\n"
	s += tr("敌方增加%d%%的增伤和减伤") % lv + "\n"
	self.dec = s
	self.txt = "%d" % lv

func _in():
	sys.game.connect("onBattleReady",self,"_bat")
	
func _bat():
	if lv > 0:
		for i in sys.batScene.getAllChas():
			if i.team != sys.player.team :
				i.castBuff(i,"b_a_dark",lv)

