extends Scene
class_name BatScene

signal onSetTxt()

var faci 
var isBattle = false setget setIsBattle
var enemyTeam 
var isWin = false
var isEnd = false
var xp = 0
var playChaNum = 0 #玩家的单位数量
var lv = 1
var playDeathNum = 0
var txt setget setTxt
func setTxt(val):
	txt = val
	emit_signal("onSetTxt")

func initTeam(enemyTeam:Team):
	.init()
	self.enemyTeam = enemyTeam
	rect_position = Vector2(80,78)
	
	addTeam(sys.player.team,0)
	addTeam(enemyTeam,1)
	battleReady()
	Engine.time_scale = sys.game.spd

func setIsBattle(val):
	isBattle = val
	for i in objMap.get_children():
		if i is CharaV : 
			i.setProcess(val)
			if i.chara.team == sys.player.team:
				i.isDrag = !val

var objNumDs = {}

func addTeam(team:Team,inx = 0):
	objNumDs[team] = 0
	for cha in team.chas:
		if cha.cell.x < 5 :
			if cha.isDeath :
				cha.revive(false)
				cha.plusHp(1)
			cha.aiCha = null
			if inx == 0 :
				cha.dire = 1
				addObj(cha)
				sys.game.emit_signal("onChaInScene",cha)
			else:
				cha.dire = -1
				addObj(cha,Vector2(9-cha.cell.x,cha.cell.y))
				sys.game.emit_signal("onChaInScene",cha)
			if cha.team == sys.player.team:
				playChaNum += 1

func addObj(obj:Obj,cell = null):
	if cell == null:
		cell = obj.cell
	else:
		obj.cell = cell
	var objV = preload("res://tscn/chara/charaV.tscn").instance()
	objMap.add_child(objV)
	if .addObj(obj,cell) == false:return
	objNumDs[obj.team] += 1
	objV.connect("onDelEnd",self,"rDelEnd")
	objV.init(obj)
	objV.setProcess(false)
	newEff("e_zhao",objV.position)
	return obj
	
func _input(event):
	if event.is_action_pressed("ui_down") :
		for i in objMap.get_children():
			if i is Label:
				i.free()
		for i in aStar.get_point_connections(cellToId(Vector2(3,2))):
			showCell(aStar.get_point_position(i))
	
func _cellPressed(cell):
	._cellPressed(cell)
	var cha = matObj(cell)
	if cha != null:
		sys.newDlg("res://tscn/charaDlg/charaDlg.tscn").init(cha)
	
func showCell(cell):
	var lab = Label.new()
	var obj = matObj(cell)
	if obj == null:
		lab.text = "%s:%s" % [cell,""]
	else:
		lab.text = "%s:%s" % [cell,obj.name]
	objMap.add_child(lab)
	lab.rect_position = map_to_world(cell) + Vector2(-20,-20)

var cds = {}
func battleStart():
	for i in getAllChas():
		cds[i] = i.cell
	emit_signal("onBattleStart")
	sys.game.emit_signal("onBattleStart")
	self.isBattle = true
	if objNumDs[sys.player.team] <= 0 :
		battleEnd(false)
	elif objNumDs[enemyTeam] <= 0 :
		battleEnd(true)
	
func rDelEnd(obj):
	obj.delAllConnect()
	obj.delAllAff()
	
	objNumDs[obj.team] -= 1
	if objNumDs[obj.team] <= 0 && isBattle == true:
		self.isBattle = false
		if obj.team == sys.player.team :
			battleEnd(false)
		else:
			battleEnd(true)
			
func battleEnd(isWin):
	self.isWin = isWin
	self.isBattle = false
	isEnd = true
#	for i in sys.player.team.chas :
#		i.delAllBuff()
#	for i in enemyTeam.chas :
#		i.delAllBuff()
	sys.game.emit_signal("onBattleEndStart",self.isWin)
	for i in getAllChas():
		if i.isSummon :
			i.del()
	if isWin:
		if sys.game.isNight():
			xp *= 1.5
	for i in cds:
		_setMatObj(cds[i])
		i.matMoveUp(cds[i])
		i.dire = 1
		if i.team == sys.player.team && i.isDeath:
			i.revive(false)
			i.plusHp(1)
			playDeathNum += 1
		elif i.team != sys.player.team && isWin == false:
			i.revive()
		i.ward = 0
	emit_signal("onBattleEnd",isWin)
	sys.game.emit_signal("onBattleEnd",isWin)
			
func battleReady():
	for i in getAllChas():
		cds[i] = i.cell
	self.isBattle = false
	emit_signal("onBattleReady")
	sys.game.emit_signal("onBattleReady")
	
func can_drop_data(pos, data):
	if data is CharaV && data.chara != null && data.chara.team == sys.player.team:
		return true
	return false
	
func drop_data(position, data):
	var cell = data.obj.cell
	var newCell = world_to_map(position)
	if newCell.x > 4:
		return
	matSwap(newCell,data.obj)
	data.upPosition()
	var cha = matObj(cell)
	if cha != null && is_instance_valid(cha.vis):
		cha.vis.upPosition()

func getEnemyCenterCell(team):
	var p = Vector2.ZERO
	var total = 0
	for cha in getAllChas():
		if cha.team != team && cha.isDeath == false:
			p.x += cha.position.x
			p.y += cha.position.y
			total += 1
	if p == Vector2.ZERO :return Vector2.ZERO
	p.x /= total
	p.y /= total
	return world_to_map(p)

func _on_scene_tree_entered():
	sys.batScene = self

func del():
	Engine.time_scale = 1.0
	.del()

func _on_scene_tree_exiting():
	del()
