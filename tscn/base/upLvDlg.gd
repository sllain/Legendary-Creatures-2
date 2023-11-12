extends BaseDlg

onready var box = $now3/HBoxContainer
var item 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var ds = {}
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(item):
	self.item =item
	tile.text = item.name
	var item2 = data.newBase(item.id)
	item2.lv = item.lv + 1
	$now/txc.bbcode_text = item.getDec()
	$now2/txc.bbcode_text = item2.getDec()
	$now/Label.text = tr("当前 等级:%d") % [item.lv]
	$now2/Label.text = tr("升级后 等级:%d") % [item.lv+1]
	ds.clear()
	if item.lvUps.size() <= 0 :
		$now3/Label.hide()
	for i in item.lvUps:
		var mt = data.newBase(i)
		mt.num = sys.lvPer(item.lv,item.lvUps[i],0.5)
		ds[mt.id] = mt.num
		var it = preload("res://tscn/item/itemBtn.tscn").instance()
		box.add_child(it)
		it.init(mt)
		
func _on_Button_pressed():
	if sys.player.subItems(ds) :
		item.lv += 1
		item.masCha.sp -= 1
		del()
	else:
		del()
		sys.newMsg("材料不足")
