extends Att
class_name Obj  #能被放置在Scene上的物体

signal onSetCell()
signal onSetGoalCell()
signal onUpPosition()
signal onSetVisible()

var isDeath = false
var goalCell 
var vis
var visible = true setget setVisible
var cell:Vector2 setget setCell
var position := Vector2.ZERO
var icoId = "ico_chara"
func setCell(val):
	if self.cell == val :return
	cell = val; emit_signal("onSetCell")

func matMove(cell):
	if self.cell == cell :
		return false
	return scene.matMove(cell,self)
	
func matMoveUp(cell):
	cell = scene.getNullCell(cell)
	if matMove(cell) :
		emit_signal("onUpPosition")

#到另一个单位的距离
func distanceTo(obj):
	return scene.oddr_distance(cell,obj.cell)
	
func distanceToCell(cell):
	return scene.oddr_distance(self.cell,cell)

func del():
	.del()
	if scene != null:
		scene.exitMat(self)
	
func _process(delta):
	pass

func setVisible(val):
	visible = val
	emit_signal("onSetVisible")

func inScene(scene):
	self.scene = scene
	if mas == null:
		inStart(sys.game)
		
func getSave():
	var ds = {
		cell = cell,
		visible = visible,
	}
	ds.merge(.getSave())
	return ds

func setSave(ds):
	.setSave(ds)
	dsSet("cell",ds)
	dsSet("visible",ds)
	return self
