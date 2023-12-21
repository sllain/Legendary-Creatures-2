extends TextureButton
class_name ItemBtn

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var imgNode = $imgNode
onready var img = $imgNode/img

var item
var txt = ""
var isInfo = true
var isDrag = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(item:Item):
	if item == null :
		img.texture = null
		self.item = null
		txt = ""
		$Label.hide()
		self_modulate = Color("#ffffff")
		return
	self.item = item
	up()
	cdel()
	item.connect("onSetNum",self,"num")
	item.connect("onSetLv",self,"_setLv")
	
func _setLv():
	call_deferred("up")
	
func up():
	if item == null:return
	txt = "\n[b][color=%s]%s\n[/color][/b]" % [cons.colorDs.lvs[item.lv-1],tr(item.name)]
	if item is Gem :
		if item.lv > 3 :
			txt += "%s\n" % tr("特殊宝石")
		else:
			txt += "%s\n" % tr("普通宝石")
		txt += "%s\n" % tr("用于铁匠铺升级装备")
	elif item is Eqp && item.isOnly  :
		txt += "%s\n" % tr("独一无二")
	
	
	var gemStr = ""
	if item is Eqp :
		for i in cons.attDs:
			if item[i] != 0 :
				if cons.attDs[i].isPer :
					txt += "[color=%s]+ %d%% %s[/color]\n" % [cons.colorDs.att,item[i] * 100,tr(cons.attDs[i].name)]
				else:
					txt += "[color=%s]+ %d %s[/color]\n" % [cons.colorDs.att,item[i],tr(cons.attDs[i].name)]
		txt += "\n"
		for i in item.gems.items:
			gemStr += "[color=%s]%s[/color]\n" % [cons.colorDs.lvs[i.lv-1],i.dec]
	
	txt += gemStr
	if item.dec != "" :
		txt += "[color=%s]%s[/color]\n"  % [cons.colorDs.lvs[item.lv-1],item.dec]
	var tips = "\n"
	for i in cons.tipDs:
		if txt.find(tr(i)) != -1:
			tips += "%s:%s\n" % [tr(i),tr(cons.tipDs[i])]
	tips = "[color=#999999]%s[/color]" % tips
	txt += tips
	txt = "[center]%s[/center]" % txt
	img.texture = data.newRes(item.icoId)
	sys.addTip(self,txt)
	self_modulate = Color(cons.colorDs.lvs[item.lv-1])
	if item.lv > 1 :
		self_modulate.v *= 1.25
	if item.isNum :
		$Label.show()
		$Label.text = "%d" % item.num
	else:
		$Label.hide()
	
func cdel():
	item.connect("onExit",self,"queue_free")

func _on_item_pressed():
	if item != null && isInfo && Input.is_action_pressed("ui_ctrl") == false:
		sys.newDlg("res://tscn/item/itemInfoDlg.tscn").init(item,txt)

func num():
	if item == null :return
	$Label.text = "%d" % item.num

func _on_item_mouse_entered():
	if item == null:return
	var tween = get_tree().create_tween()
	tween.tween_property(imgNode, "scale", Vector2(1.2,1.2), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_item_mouse_exited():
	if item == null:return
	var tween = get_tree().create_tween()
	tween.tween_property(imgNode, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func get_drag_data(position):
	if isDrag && item != null:
		var node = Control.new()
		var n2 = imgNode.duplicate()
		n2.position -= img.rect_size * 0.5
		node.add_child(n2)
		set_drag_preview(node)
		return self
