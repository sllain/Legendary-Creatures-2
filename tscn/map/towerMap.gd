extends Map


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var p
var p2
var startCell 
var endCell
var lines = []
var rings = []
var cn = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _init():
	pass
	#faciRp.addItem("")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func newMap():
	#cellNum = sys.lvPer(sys.mapScene.lv,40,0.5)
	matKeys[0] = []
	p = get_cellv(Vector2(sys.mapScene.lv-1,0))
	p2 = get_cellv(Vector2(sys.mapScene.lv-1,1))
	clear()
	startCell = Vector2(50,50)
	endCell = startCell
	for i in 5:
		ring(2)
		line()
	ring(2)
	startCell = Vector2(52,50)
	saveMap()
	
func ring(ran = 2):
	rings.append(endCell + Vector2(2,0))
	for i in sys.mapScene.getCells(endCell + Vector2(2,0),ran):
		set_cellv(i,p)
	endCell.x += ran * 2 + 1
	
func line(ran = 3):
	for i in ran :
		set_cellv(endCell+Vector2(i,0),p2)
		lines.append(endCell+Vector2(i,0))
	endCell.x += ran

func initFaci():
	sys.game.globals.g_tMap.initFaci()

