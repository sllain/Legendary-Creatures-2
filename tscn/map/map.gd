extends TileMap
class_name Map
var mapId = ""
var matKeys := {}
	
func newMap():
	saveMap()

func saveMap():
	var mapDs = {}
	for i in get_used_cells():
		mapDs[i] = get_cellv(i)
	var file = File.new()
	if file.open(sys.game.dataDir + "/%s.map" % mapId,File.WRITE) == OK :
		file.store_var(mapDs)
		file.close()
	else:
		printerr("地图保存失败")
	
func loadMap():
	clear()
	var file = File.new()
	if file.open(sys.game.dataDir + "/%s.map" % mapId,File.READ) == OK:
		var ds = file.get_var()
		file.close()
		for i in ds:
			set_cellv(i,ds[i])
	else:
		printerr("地图读取失败")

var matLvPool := RndPool.new()
func getRndCell():
	return getRndLvCell(matLvPool.rndItem())

func getRndLvCell(lv):
	if lv > 4 :lv = 4
	var cell = sys.rndListItem(matKeys[lv])
	matKeys[lv].erase(cell)
	if cell == null :
		cell = Vector2(50,50)
	return cell
