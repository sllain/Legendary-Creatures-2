extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var mas 
var chara
# Called when the node enters the scene tree for the first time.

func init(mas):
	self.mas = mas
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_drag_data(position):
	if mas == null || mas.get("isDrag") == null: return
	if mas.isDrag && mas.obj != null:
		var node = Control.new()
		var n2 = mas.anim.duplicate()
		n2.position.y += 20
#		n2.rect_position = -n2.rect_size * 0.5
		node.add_child(n2)
		set_drag_preview(node)
		if mas is CharaV :
			return mas

#func drop_data(position, data):
#	mas.emit_signal("onDrop",data,position)
#
#func can_drop_data(pos, data):
#	if data.type == "itemBt" || data.type == "eqpBt":
#		return true
#	return false
func drop_data(position, data):
	for i in chara.eqps.items.size():
		if chara.eqps.items[i] == null:
			chara.setEqp(data.item,i)
			return

func can_drop_data(pos, data):
	if data is EqpLBtn || data is EqpChaBtn:
		return true
	return false
