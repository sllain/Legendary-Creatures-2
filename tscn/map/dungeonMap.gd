extends Map


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cellNum = 60
var cellNumVal = 0
var p 
var endCell
var cn = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func newMap():
	#cellNum = sys.lvPer(sys.mapScene.lv,40,0.5)
	cellNumVal = cellNum
	matKeys[0] = []
	p = get_cellv(Vector2.ZERO)
	clear()
	set_cellv(Vector2(50,50),p)
	g(Vector2(50,50))
	for j in [Vector2(0,0),Vector2(50,50),endCell]:
		for i in sys.mapScene.getCells(j,2):
			set_cellv(i,p)
	saveMap()

func g(cell):
	var x = sys.rndRan(2,3)
	#var x = 4
	var list = []
	for i in sys.mapScene.getCells1(cell) :
		list.append(i)
	list.shuffle()
	for i in list:
		var xcell = i + cell
		if get_cellv(xcell) == -1 && cellNumVal > 0:
			endCell = xcell
			set_cellv(xcell,p)
			matKeys[0].append(xcell)
			cellNumVal -= 1
			x -= 1
			if x <= 0 :
				break
			if cellNumVal > 0 :
				g(xcell)
				
func initFaci():
	for i in 10 :
		if endCell.distance_to(Vector2.ZERO) < 3 :
			endCell = getRndCell()
		else:
			break
	var fn = 0
	for i in data.getList("faci"):
		if fn > cellNum * 0.8 : break
		var idFaci = data.newBase(i.id)
		if idFaci.lock != 1 :continue
		if idFaci.checkMode(sys.game.mode) == false:continue
		if idFaci.hasTab("dungeon") == false :continue
		if idFaci.id.split("_").size() > 2 : continue
		var faciNum = idFaci.num
		if idFaci.dnum > 0 :
			faciNum = idFaci.dnum
		
		for j in faciNum :
			var faci
			if rnp.subPoolDs.has(idFaci.id) :
				faci = data.newBase(rnp.subPoolDs[idFaci.id].rndItem(self,"rndf").id) 
			else:
				faci = data.newBase(idFaci.id)
			faci._createStart()
			faci.cell = getRndLvCell(0)
			faci.lv = sys.mapScene.lv
			sys.mapScene.addObj(faci)
			fn += 1
			faci._create()
	
func rndf(faci:Faci):
	if faci.hasTab("dungeon") :
		return true
	return false

func getRndCell():
	return getRndLvCell(0)
