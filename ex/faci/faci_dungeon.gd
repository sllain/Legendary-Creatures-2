extends Faci
class_name FaciDungeon

func _data():
	name = "地牢"
	dec = ""
	weight = 1
	isShowIco = false
	tab = "world"
	isCs = true
	num = nums.size()

var dId = ""
const nums = [1,1,1,2,2,2,3,3,4,4]
	
func _createStart():
	createLv = nums[0]
	nums.remove(0)

func setLv(val):
	.setLv(val)
	name = ["地牢","洞穴","遗迹","遗迹","遗迹"][lv-1]

func _trig():
	var inx = yield(sys.eventDlg.sel([tr("进入"),tr("离开")]),"onSel")
	if inx == 0 :
		var isInit = dId == ""
		dId = sys.game.getRndDungeonId(dId)
		sys.game.toMap(dId,Vector2(50,50),lv)
		sys.player.worldCell = cell
		if isInit :
			var efaci = data.newBase("faci_batBoss")
			efaci.cell = sys.mapScene.getNullCell(sys.mapScene.map.endCell)
			efaci.lv = lv
			sys.mapScene.addObj(efaci)
			if lv >= 3 :
				efaci = data.newBase("faci_batYouAn")
				efaci.cell = sys.mapScene.getNullCell(sys.mapScene.map.endCell)
				efaci.lv = lv
				sys.mapScene.addObj(efaci)

func getSave():
	var ds = {
		dId = dId,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("dId",ds)
