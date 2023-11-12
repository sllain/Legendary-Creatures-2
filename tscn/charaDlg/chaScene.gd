extends Scene
class_name ChaScene

signal onChaMove()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mas 
# Called when the node enters the scene tree for the first time.
func _ready():
	mas = get_parent()

func initPlayer(player:Player):
	.init()
	for i in player.team.chas :
		addObj(i)
		sys.game.emit_signal("onChaInScene",i)
		
	player.team.connect("onAddCha",self,"addObj")

func addObj(obj:Obj,cell = null):
	cell = obj.cell
	var objV = preload("res://tscn/chara/charaV.tscn").instance()
	objMap.add_child(objV)
	objV.isDeathDel = false
	obj.scene = self
	.addObj(obj,cell)
	objV.init(obj,true)
	objV.set_physics_process(false)
	return obj

func _input(event):
	if event.is_action_pressed("ui_down") :
		for i in objMap.get_children():
			if i is Label:
				i.free()
		for i in aStar.get_point_connections(cellToId(Vector2(3,2))):
			showCell(aStar.get_point_position(i))
			
			
func showCell(cell):
	var lab = Label.new()
	var obj = matObj(cell)
	if obj == null:
		lab.text = "%s:%s" % [cell,""]
	else:
		lab.text = "%s:%s" % [cell,obj.name]
	objMap.add_child(lab)
	lab.rect_position = map_to_world(cell) + Vector2(-20,-20)

func drop_data(position, data):
	if data is CharaV:
		var cell = data.obj.cell
		var newCell = world_to_map(position)
		var oldCha = matObj(newCell)
		var oldP = 0 if oldCha == null else 1
		if cell.x < 5 && newCell.x < 5 :
			pass
		elif cell.x < 5 && mas.popl - 1 + oldP > sys.player.maxPopl:
			sys.newMsg("人口不足")
			return
		elif newCell.x < 5 && mas.popl + 1 - oldP > sys.player.maxPopl:
			sys.newMsg("人口不足")
			return
		matSwap(newCell,data.obj)
		data.upPosition()
		var cha = matObj(cell)
		if cha != null && is_instance_valid(cha.vis):
			cha.vis.upPosition()
		sys.playSe("JumpDown.wav")	
		emit_signal("onChaMove")
	elif data is EqpChaBtn :
		var cha:Chara = data.item.wearer 
		for i in cha.eqps.items.size():
			if cha.eqps.items[i] == data.item :
				cha.setEqp(null,i)
				break

func can_drop_data(pos, data):
	if data is CharaV || data is EqpChaBtn:
		return true
	return false

var ups = 0.0
func _process(delta):
	if ups < 1 :
		ups += delta
		if ups >= 1 :
			_upS()
			ups= 0.0

func _upS():
#	for i in objs.items:
#		if i is Chara :
#			i.upAllAtt()
	pass
