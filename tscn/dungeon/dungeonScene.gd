extends MapScene
class_name DungeonScene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func init():
	self.playFaci = Faci.new()
	playFaci.cell = Vector2(1,2)
	.init()

var nowNum = 0
func ex(cell):
	var cs = getCells1(cell)
	var newCell = sys.rndListItem(cs)
	map.set_cellv(newCell,0)
	nowNum += 1
	if nowNum > 10 :
		return
	ex(newCell)
