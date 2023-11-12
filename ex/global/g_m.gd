extends Global

var nextMlv = 1
var maxMlv = 30
var mp = 1

func _data():
	name = "瘴气"
	txt = "0"
	isVisIco = true
	lv = 0
	excMode = "tower"
	
func setLv(val):
	.setLv(val)
	if lv > maxMlv :lv = maxMlv
	var s = tr("%d 级") % lv + "\n"
	s += tr("敌方的生命，防御，攻击提高%d%%") % [lv * mp] + "\n"
	s += tr("每过一天提高%d级") % [nextMlv] + "\n"
	self.dec = s
	self.txt = "%d" % lv
	
	if lv == 5 && msgBlDs.has("miasma5") == false:
		sys.newMsg(tr("瘴气到达了5级，请注意瘴气的流逝，瘴气越高，敌人越强"))
		msgBlDs["miasma5"] = true
#	elif lv >= maxMlv && msgBlDs.has("end") == false :
#		sys.newMsg(tr("瘴气到达%d级，游戏失败！") % maxMlv)
#		sys.game.end(false)
#		msgBlDs["end"] = true

func _in():
	sys.game.connect("onBattleReady",self,"_bat")
	sys.game.connect("onNextDay",self,"_nextDay")

func _bat():
	#self.isVisIco = true && lv > 0
	if lv > 0:
		for i in sys.batScene.getAllChas():
			if i.team != sys.player.team :
				i.castBuff(i,"b_a_zhangQi",lv).mp = mp

var msgBlDs = {}

func _nextDay():
	self.lv += nextMlv
