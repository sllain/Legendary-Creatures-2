extends Global

func _data():
	name = "战况激烈"
	txt = "50%%"
	isVisIco = false
	
var isBat = false

func setLv(val):
	if val > 20 : val = 20
	.setLv(val)
	self.dec = tr("每30秒所有单位最终伤害提升50%") 
	self.txt = "%d%%" % [lv * 50]
	if lv > 0 :
		sys.game.connect("onChaCastHurtStart",self,"r")
		self.isVisIco = true

func _in():
	self.lv = 0
	self.isVisIco = false
	sys.game.connect("onBattleReady",self,"_ready")
	sys.game.connect("onBattleEnd",self,"_batEnd")
	sys.game.connect("onBattleStart",self,"_batStart")

func _ready():
	isVisIco = false
		
func _batEnd(win):
	off()
	
func _batStart():
	off()
	isBat = true
	var chas = sys.batScene.getAllChas()
	for i in chas:
		if i.team == sys.player.team :
			if i.hasTab("刺客"):
				i.castBuff(i,"b_a_yinShen",5)
			if i.hasTab("战士"):
				i.castBuff(i,"b_a_plusPer",20)
	
func off():
	isBat = false
	batS = 0
	self.lv = 0
	sys.game.disconnect("onChaCastHurtStart",self,"r")
	sys.game.disconnect("onChaCastPlusStart",self,"r2")
	self.isVisIco = false

var batS = 0.0
func _process(delta):
	if isBat == false : return
	batS += delta
	if batS >= 30 :
		self.lv += 1
		batS = 0.0
		
func r(atkInfo):
	atkInfo.finalPer += lv * 0.5
	
func r2(info):
	info.finalPer -= lv * 0.3
