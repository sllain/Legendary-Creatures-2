extends Map
class_name WorldMap

var noise = OpenSimplexNoise.new()
var noise2 = OpenSimplexNoise.new()

var deep_ocean=3
var ocean=0

var size = 100
var cls = {}

var matInfoDs := {}

func _ready():
	for x in range(-5,23):
		for y in range(-5,23):
			cls[Vector2(x,y)] = get_cell(x,y)

	deep_ocean = get_cell(0,-1)
	ocean = get_cell(1,-1)

func heat(pos):
	return abs(pos.y/(0.5 * size))

func falloffValue(pos):
	var value = max(abs(pos.x)/(0.6 * size),abs(pos.y)/(0.6 * size))
	value = evalueate(value)
	return value

func evalueate(x):
	var a = 3
	var b = 2.2
	var value = pow(x,a)/(pow(x,a) + pow(b - b * x,a))
	return value

func generateLand(size):
	noise.seed = randi()
	noise.octaves = 3
	noise.period = 30
	noise.persistence = 0.5
	noise.lacunarity = 2
	
	noise2.seed = randi()
	noise2.octaves = 3
	noise2.period = 30
	noise2.persistence = 0.5
	noise2.lacunarity = 2
	
	for x in range(-0.5 * size,0.5 * size):
		for y in range(-0.5 * size,0.5 * size):
			var pos = Vector2()
			pos.x = x
			pos.y = y
			var height = getHeightv(pos) + 0.25
			var heat = ( (noise2.get_noise_2dv(pos)) * height)
			
			if height >= -0.1 and height <= 0:
				setCell(pos,ocean)
			elif height <= -0.1:
				setCell(pos,deep_ocean)
			elif height > 0:
				var cx = int(height*30)
				cx = sys.rndRan(cx,cx+1)
				cx = clamp(cx,0,22)
				var cy = int(heat*45) + 11
				#cy = sys.rndRan(cy,cy+1)
				cy = clamp(cy,0,22)
				setCell(pos,cls[Vector2(cx,cy)])
				var ds = {
					height = height,
					heat = heat,
					cx=cx,
					cy=cy,
					lv = clamp(int((height + 0.12) * 6 ),1,4) 
				}
				var cell = pos + Vector2(size * 0.5,size * 0.5)
				matInfoDs[cell] = ds
				if matKeys.has(ds.lv) == false:
					matKeys[ds.lv] = []
				matKeys[ds.lv].append(cell)
	
func setCell(cell,inx):
	set_cellv(cell + Vector2(size * 0.5,size * 0.5),inx)

func generate():
	generateLand(size) # 生成海陆图
	for i in 10 :
		he(sys.rndListItem(matKeys[sys.rndListItem(matKeys.keys())]),sys.rndRan(20,30))
		#generate_river(x,y)

func getHeightv(pos):          
	var value = noise.get_noise_2dv(pos) - falloffValue(pos)
	return value

func he(cell,n):
	var list = []
	for i in sys.mapScene.getCells1(cell) :
		list.append(i)
	list.shuffle()
	for i in list:
		var xcell = i + cell
		if matInfoDs.has(xcell) && matInfoDs[xcell].height < 0.25 && (get_cellv(xcell) in [-1,ocean,deep_ocean]) == false && n > 0:
			set_cellv(xcell,ocean)
			n -= 1
			matKeys.erase(xcell)
			if n > 0 :
				he(xcell,n)	
			break

func initFaci():
	for i in matKeys:
		matLvPool.addItem(i,matKeys[i].size())
	var d = 0
	var townCells = []
	var maxHcell = null
	for i in data.getList("faci"):
		var idFaci:Faci = data.newBase(i.id)
		if data.isUsable(idFaci) == false :continue
		if idFaci.hasTab("world") == false :continue
		if idFaci.checkMode(sys.game.mode) == false:continue
		if idFaci.id.split("_").size() > 2 : continue
		for j in idFaci.num :
			var faci
			if rnp.subPoolDs.has(idFaci.id) :
				faci = data.newBase(rnp.subPoolDs[idFaci.id].rndItem(self,"rndf").id) 
			else:
				faci = data.newBase(idFaci.id)
			faci._createStart()
			if faci.createLv == 0:
				faci.cell = getRndCell()
			else:
				faci.cell = getRndLvCell(faci.createLv)
			faci.lv = matInfoDs[faci.cell].lv
			sys.mapScene.addObj(faci)
			if faci.id == "faci_town" :
				set_cellv(faci.cell, cls[Vector2(matInfoDs[faci.cell].cx,-2)] )
				if faci.lv == 1 :
					townCells.append(faci.cell)
			elif faci.id == "faci_dungeon" :
				set_cellv(faci.cell, cls[Vector2(matInfoDs[faci.cell].cx,-4)] )
			if maxHcell == null || matInfoDs[maxHcell].height < matInfoDs[faci.cell].height :
				maxHcell = faci.cell
			d += 1
			faci._create()
			if get_cellv(faci.cell) in [338,341]:
				set_cellv(faci.cell, 307 )
			
	saveMap()
	var mCell = Vector2.ZERO
	var c = Vector2(50,50)
	for i in townCells:
		if mCell.distance_to(c) > i.distance_to(c) :
			mCell = i
	sys.player.cell = mCell
	var m = data.newBase("faci_batMoWang")
	m.cell = maxHcell
	m.lv = 5
	sys.mapScene.addObj(m)
	
func addCs(cell,id,lv):
	var faci = data.newBase(id)
	faci.cell = cell
	faci.lv = lv
	sys.mapScene.addObj(faci)
	return faci
	
func newMap():
	clear()
	matInfoDs.clear()
	matKeys.clear()
	generate()
	if matKeys.has(4) == false:
		newMap()

func rndf(faci:Faci):
	if faci.hasTab("world") :
		return true
	return false
