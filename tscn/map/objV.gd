extends Node2D
class_name ObjV
signal onDelEnd(obj)

var obj:Obj
var mPath = []
var isMove = false
var isItem = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func setProcess(val = false):
	set_physics_process(val)
	set_process(val)

func init(obj):
	self.obj = obj
	obj.vis = self
	if isItem :
		setProcess(false)
		return
	obj.connect("onSetCell",self,"rSetCell")
	#obj.connect("onSetGoalCell",self,"rSetGoalCell"
	obj.connect("onDel",self,"_del")
	obj.connect("onUpPosition",self,"rUpPos")
	obj.connect("onSetVisible",self,"rSetVisible")
	upPosition()
	rSetVisible()
	
func _del():
	emit_signal("onDelEnd",obj)
	queue_free()
	
func rSetVisible():
	visible = obj.visible
	
var nextTgPos
func rSetCell():
	if isItem : return
	nextTgPos = obj.scene.map_to_world(obj.cell)
	
func rUpPos():
	upPosition()
	obj.scene.newEff("e_zhao",position)
	
func upPosition():
	rSetCell()
	position = nextTgPos
	obj.position = position
	
var pathInx = 0
func upPath():
	if obj.cell == obj.goalCell : 
		mPath = []
		return
	var objb = obj.scene.matObj(obj.goalCell)
	obj.scene._setMatObj(obj.goalCell,null)
	mPath = obj.scene.getCellPath(obj.cell,obj.goalCell)
	obj.scene._setMatObj(obj.goalCell,objb)
	if mPath.size() <= 0 :
		mPath = obj.scene.getLined(obj.cell,obj.goalCell)
	pathInx = 1
	
func pathNext():
	if mPath.size() > pathInx:
		if obj.matMove(mPath[pathInx]):
			pathInx += 1
			isMove = true
			_moveStart()
			
func _physics_process(delta):
	obj.position = position
	if isMove == false && obj.goalCell != null && _ifMove():
		upPath()
		pathNext()

func _process(delta):
	if isMove :
		var s = delta * 200
		position = position.move_toward(nextTgPos,s)
		if position.distance_to(nextTgPos) <= s:
			isMove = false
			if obj.goalCell == null || obj.cell == obj.goalCell:
				_moveEnd()

func _ifMove():
	return true
func _moveStart():
	pass
func _moveEnd():
	pass
