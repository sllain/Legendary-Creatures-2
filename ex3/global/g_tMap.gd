extends Global

var boss :Faci

func _data():
	excMode = "map"
	
func _in():
	sys.game.connect("onTrigFaci",self,"_trigFaci")
	sys.player.upSkillNum = 4

func _trigFaci(boss,id,info):
	if id == "bossDel" :
		var faci = data.newBase("faci_tNext")
		faci.cell = boss.cell + Vector2(2,0)
		sys.mapScene.addObj(faci)

func initFaci():
	var lines = sys.mapScene.map.lines
	var rings = sys.mapScene.map.rings
	
	for i in lines.size() :
			var cell = lines[i]
			var id = "faci_bat"
			if (i+1) % 3 == 0 :
				id = "faci_bat2"
			var bat :FaciBat= faciCreate(id,cell)
			bat.powM *= 1.0 + (i * 0.05)
			bat.bonusR = 4
			if id == "faci_bat2" :bat.origin = "地牢"
			bat.canPerfect = false
			
	faciCreate("faci_n6-relicIni",rings[0])
	if lv > 1 :
		if lv % 2 :
			faciCreate("faci_n3",rings[0]) #洗点
		else:
			faciCreate("faci_buy",rings[0]) #买
	else:
		faciCreate("faci_eqpUp",rings[0])
	
	faciCreate("faci_town",rings[1]).isShowIco = true
	faciCreate(rnp.subPoolDs["faci_unk"].rndItem().id,rings[1]) #问号
	
	faciCreate(rnp.subPoolDs["faci_unk"].rndItem().id,rings[2]) #问号
	faciCreate("faci_box2",rings[2])
	
	if lv % 2 == 0 :
		faciCreate("faci_pop",rings[3]) #人口
	else:
		faciCreate("faci_n8",rings[3]) #智者
	faciCreate(rnp.subPoolDs["faci_unk"].rndItem().id,rings[3]) #问号
	
	var sl = ["faci_diLaoYongBing","faci_jiTang","faci_lianMeng","faci_diLaoYongBing","faci_jiTang","faci_lianMeng"]
	faciCreate(sl[lv-1],rings[4])
	if lv == 3 || lv == 6 :
		faciCreate("faci_n1",rings[4])
	else:
		faciCreate("faci_rouTi",rings[4])
	
	var bossId = "faci_batBoss"
	if lv >= 6 :
		bossId = "faci_batMoWang"
	elif lv >= 5 :
		bossId = "faci_haiYang"
	elif lv >= 2 :
		bossId = "faci_batTianWang"
	var boss = faciCreate(bossId,rings[5])
	boss.bonusR = 4
	if lv == 1  :
		boss.origin = "地牢"
	faciCreate("faci_repHp",rings[5])
		
func faciCreate(id,cell):
	var faci = data.newBase(id)
	faci.cell = cell
	faci._createStart()
	faci.lv = lv
	faci.isCs = false
	faci.isShowIco = true
	sys.mapScene.addObj(faci)
	faci._create()
	return faci

func next():
	self.lv += 1
	sys.game.globals.g_tDark.lv += 5
	sys.game.toMap(sys.game.getRndDungeonId(),Vector2(50,50),lv)
