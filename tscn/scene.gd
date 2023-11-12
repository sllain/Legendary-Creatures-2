extends Control
class_name Scene

signal onObjPressed(unit)
signal onCellPressed(cell)
signal onAddObj(obj)
signal onDelObj(obj)
signal onSetMatObjStart(cell,obj)
signal onSetMatObj(cell,obj)

signal onBattleReady()
signal onBattleStart()
signal onBattleEnd(isWin)

onready var map :TileMap= $map
onready var objMap:TileMap = $objMap

onready var ui = $ui
onready var mouseCell = $mouseCell
onready var k = $k

var aStar :AStar2D= AStar2D.new()
var mat:Dictionary = {}
var cellRect:Rect2
var rect:Rect2
var p1
var mapSizePer = 0.27
var objs = ItemPck.new()

var queues = []
class Queue:
	var obj 
	var f
	var arr
	
var noWalkInx = [-1]
#var noWalkInx = [-1]

func init():
	map.scale = Vector2(mapSizePer,mapSizePer)
	#rect = Rect2(margin_left,margin_top,margin_right,margin_bottom)
	var rectl = map.get_used_rect()
	cellRect = rectl
	rectl.position -= Vector2(1,1)
	rectl.end += Vector2(2,2)
	rect = Rect2(map_to_world(rectl.position),map_to_world(rectl.size))

	k.margin_left = rect.position.x
	k.margin_top = rect.position.y
	k.margin_right = rect.end.x
	k.margin_bottom = rect.end.y
	
#	camera.limit_left = int(mapRect.margin_left)
#	camera.limit_top = int(mapRect.margin_top)
#	camera.limit_right = int(mapRect.margin_right)
#	camera.limit_bottom = int(mapRect.margin_bottom)
	p1 = cellRect.position
	#p1 = Vector2.ZERO
	var p2 = cellRect.end #+ Vector2(2,2)
	#var t = OS.get_ticks_msec()
	for x in range(p1.x,p2.x):
		for y in range(p1.y,p2.y):
			var inx = map.get_cell(x,y)
			if noWalkInx.has(inx) == false:
				var v = Vector2(x,y)
				mat[v] = null
				aStar.add_point(cellToId(v),v)

	for x in range(p1.x,p2.x):
		for y in range(p1.y,p2.y):
			var inx = map.get_cell(x,y)
			if noWalkInx.has(inx) == false:
				_initCell(Vector2(x,y),null)
	#print(OS.get_ticks_msec()-t)
	
func setMapSizePer(val):
	mapSizePer = val
	map.scale = Vector2(mapSizePer,mapSizePer)
	mouseCell.scale = Vector2(mapSizePer,mapSizePer)

func _process(delta):
	#camera.position = sys.game.player.unit.vis.position
	pass
		
func _physics_process(delta):
	if queues.size() > 0 :
		var q = queues[0]
		if is_instance_valid(q.obj):
			q.obj.callv(q.f,q.arr)
		queues.remove(0)
		
func addQueue(obj,f,arr = []):
	var q = Queue.new()
	q.obj = obj
	q.f = f
	q.arr = arr
	queues.append(q)
	
func newEff(id,pos,upPos = Vector2.ZERO):
	var eff = data.newRes(id).instance()
	objMap.add_child(eff)
	eff.position = pos
	eff.up.position = upPos
	return eff
	
#找到目标格子最近的空位
func getNullCell(cell):
	return aStar.get_point_position(aStar.get_closest_point(cell)) 
#取周围1格，性能用
func getCells1(cell):
	var vpos = Vector2(0,0)
	var cells = PoolVector2Array()
	if int(cell.y) % 2 != 0 :
		vpos = Vector2(1,0)
	cells.append(Vector2(-1,-1) + vpos) 
	cells.append (Vector2(-1,0))
	cells.append (Vector2(-1,1) + vpos)
	cells.append (Vector2(0,1) + vpos)
	cells.append (Vector2(1,0))
	cells.append (Vector2(0,-1) + vpos)
	return cells
#取范围格子
func getCells(cell=null,ran=1):
	var ls = PoolVector2Array()
	for i in cube_randraw(oddr_to_cube(cell),ran) :
		ls.append(cube_to_oddr(i))
	return ls
#取范围单位
func getCellChas(cell,ran = 1):
	var ls = cube_randraw(oddr_to_cube(cell),ran)
	var ls2 = []
	for i in ls :
		var u = matObj(cube_to_oddr(i))
		if u != null:
			ls2.insert(0,u)
	return ls2
#取全场角色
func getAllChas():
	var list = []
	for i in mat.values():
		if i != null:
			list.append(i)
	return list
#取一环格子
func getRing(cell,ran):
	var ls = PoolVector2Array()
	for i in cube_ring(oddr_to_cube(cell),ran) :
		ls.append(cube_to_oddr(i))
	return ls
#取螺旋范围格子 2d
func getSpiral(cell, ran):
	var ls = PoolVector2Array()
	for i in cube_spiral(oddr_to_cube(cell),ran):
		ls.append(cube_to_oddr(i))
	return ls
#3d转2d格子
func cube_to_oddr(cube):
	var col = cube.x + int(cube.z)/ 2
	var row = cube.z
	return Vector2(col, row)
#2d转3d格子
func oddr_to_cube(pos):
#	var x=pos.x-int(pos.y)/2
#	var y=pos.y
#	var z=-x-y
#	return Vector3(x,y, z)
	var x = pos.x-int(pos.y)/2
	var z = pos.y
	var y = -x-z
	return Vector3(x, y, z)
#两格间隔 3d
func cube_distance(a, b):
	return (abs(a.x - b.x) + abs(a.y - b.y) + abs(a.z - b.z)) / 2
#两格间隔 2d
func oddr_distance(a, b):
	return cube_distance(oddr_to_cube(a), oddr_to_cube(b))

func cube_lerp(a, b, t): # for hexes
	return Vector3(lerp(a.x, b.x, t), lerp(a.y, b.y, t),lerp(a.z, b.z, t))

func cube_round(cube):
	var rx = round(cube.x)
	var ry = round(cube.y)
	var rz = round(cube.z)
	var x_diff = abs(rx - cube.x)
	var y_diff = abs(ry - cube.y)
	var z_diff = abs(rz - cube.z)
	if x_diff > y_diff and x_diff > z_diff:
		rx = -ry-rz
	elif y_diff > z_diff:
		ry = -rx-rz
	else:
		rz = -rx-ry
	return Vector3(rx, ry, rz)
#取线段格子3d
func cube_linedraw(a, b):
	if a == b :return [a]
	var N = cube_distance(a, b)
	var results = PoolVector3Array()
	for i in range(N+1):
		results.append(cube_round(cube_lerp(a, b, 1.0/N * i)))
	return results
#取线段格子 2d	
func getLined(a,b):
	var ls = cube_linedraw(oddr_to_cube(a),oddr_to_cube(b)) 
	var ls2 = PoolVector2Array()
	for i in ls :
		ls2.append(cube_to_oddr(i))
	return ls2
#取范围格子 3d
func cube_randraw(center,N):
	var results = PoolVector3Array()
	for x in range(-N,N+1):
		for y in range(max(-N,-N - x),min(N,N-x)+1):
			var z = -x-y
			results.append(center+ Vector3(x, y, z))
	return results
var directions = [
   Vector3(+1, -1,  0), Vector3(+1,  0, -1), Vector3( 0, +1, -1),
   Vector3(-1, +1,  0), Vector3(-1,  0, +1), Vector3( 0, -1, +1)
]
func cube_direction(direction):
	return directions[direction]
func cube_neighbor(cube, direction):
	return cube + cube_direction(direction)
#取单环 3d
func cube_ring(center, radius):
	var results = []
	var cube = center + (cube_direction(4) * radius)
	for i in range(6):
		for j in range(radius):
			results.append(cube)
			cube = cube_neighbor(cube, i)
	return results
#取螺旋范围格子 3d
func cube_spiral(center, radius):
	var results = [center]
	for k in range(1,radius):
		results.append(cube_ring(center, k))
	return results

func map_to_world(cell):
	return (map.map_to_world(cell) + Vector2(map.cell_size.x * 0.5,map.cell_size.y)) * map.scale.x
	 
func world_to_map(pos):
	return map.world_to_map((pos-Vector2(0,15)) /map.scale.x)
	
func getCellPath(cell,cellTo):
	if isMatin(cellTo) == false:
		return []
	return aStar.get_point_path(cellToId(cell),cellToId(cellTo))
func cellToId(cell):
	return cell.x - cellRect.position.x + (cell.y - cellRect.position.y) * cellRect.size.x;
	#return aStar.get_closest_point(cell)

#初始化格子,勿用
func _initCell(cell,cha = null):
	if isMatin(cell):
		emit_signal("onSetMatObjStart",cell,cha)
		mat[cell] = cha
		if cha != null :
			cha.cell = cell
		var sizCells = getCells1(cell)
		for i in sizCells:
			if isMatin(i+cell):
				var nCell = i + cell
				var nCellId = cellToId(nCell);var cellId = cellToId(cell)
				var nCha = matObj(i + cell)
				if aStar.are_points_connected(cellId,nCellId): aStar.disconnect_points(cellId,nCellId)
				if cha == null && nCha == null:aStar.connect_points(cellId,nCellId);
				elif cha == null && nCha != null:aStar.connect_points(nCellId,cellId,false);
				elif cha != null && nCha == null:aStar.connect_points(cellId,nCellId,false);
		emit_signal("onSetMatObj",cell,cha)
#底层格子函数 勿用
func _setMatObj(cell,cha = null):
	if isMatin(cell):
		emit_signal("onSetMatObjStart",cell,cha)
		mat[cell] = cha
		if cha != null :
			cha.cell = cell
			aStar.set_point_disabled(cellToId(cell),true)
		else:
			aStar.set_point_disabled(cellToId(cell),false)
		emit_signal("onSetMatObj",cell,cha)

func isMatin(cell):
	if mat.has(cell):
		return true
	else:return false

func matObj(cell):
	if mat.has(cell):
		return mat[cell]
	else:return null
	
#一个新的单位放入格子
func newInMat(cell,obj):
	if obj != null && isMatin(cell) && matObj(cell) == null:
		_setMatObj(cell,obj)
		obj.cell = cell
		return true
	return false
#一个单位离开网格
func exitMat(obj):
	if isMatin(obj.cell) && matObj(obj.cell) == obj:
		_setMatObj(obj.cell,null)
		objs.delItem(obj)
		emit_signal("onDelObj",obj)
#一个单位在网格移动
func matMove(cell,obj):
	if obj != null && cell != obj.cell && matObj(cell) == null && isMatin(cell) && isMatin(obj.cell):
		var obj2 = matObj(cell)
		var cell2 = obj.cell
		_setMatObj(cell,obj)
		_setMatObj(cell2,obj2)
		return true
	return false
#一个单位和目标格子交换
func matSwap(cell,obj):
	if obj != null && cell != obj.cell && isMatin(cell) && isMatin(obj.cell):
		var obj2 = matObj(cell)
		var cell2 = obj.cell
		_setMatObj(cell,obj)
		_setMatObj(cell2,obj2)
		return true
	return false

#func shake(uration, frequency, amplitude):
#	camera.shake(uration,frequency,amplitude)
			
func _cellPressed(cell):
	pass

func addObj(obj,cell = Vector2.ZERO):
	cell = getNullCell(cell)
	if newInMat(cell,obj) :
		obj.inScene(self)
		objs.addItem(obj)
		emit_signal("onAddObj",obj)
	else:
		obj.del()
		return false
var oldRlen = 0

func relative(relative):
	pass

func delAll():
	for i in mat:
		var obj = matObj(i)
		_setMatObj(null)
	for i in range(objs.items.size()-1,-1,-1):
		var cha = objs.items[i]
		if cha != null :
			cha.del()
	objs.clear()
	for i in objMap.get_children():
		i.queue_free()
	queues.clear()

func connect(sig,target,method,binds=[],flags=0):
	if is_connected(sig,target,method) == false:
		.connect(sig,target,method,binds,flags)

func delAllConnect():
	for i in get_incoming_connections ():
		i["source"].disconnect(i["signal_name"],self,i["method_name"])	

func _on_k_gui_input(event):
	if  event is InputEventMouseButton && !event.is_pressed() && oldRlen < 5 && (event.button_index == BUTTON_LEFT || event.button_index == BUTTON_RIGHT):
		var cell = world_to_map(get_local_mouse_position())
		_cellPressed(cell)
		emit_signal("onCellPressed",cell)
		
	if event is InputEventMouseMotion :
		if  event.pressure:
			relative(event.relative)
			oldRlen += event.relative.length()
		else:oldRlen = 0
			
		var cell = world_to_map(get_local_mouse_position())
		var id = map.get_cell(cell.x,cell.y)
		if id == -1 :return
		#mouseCell.texture = map.tile_set.tile_get_texture(id)
		mouseCell.position = map_to_world(cell) + Vector2(0,-97) * mapSizePer

func del():
	delAll()

func _on_scene_tree_exited():
	del()
	pass # Replace with function body.


func _on_scene_tree_entered():
	pass # Replace with function body.
