extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var list = $ItemList
onready var tBtn = $OptionButton
var ids = []

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_OptionButton_item_selected(0)

func _on_Button_pressed():
	var id = $Control/id.text
	var type = id.split("_")[0]
	var item = data.newBase(id)
	item.lv = int($Control/lv.text)
	if type == "c" :
		sys.player.addAlterCha(item)
	elif type == "csb" || type == "eqp" || type == "gem" || type == "m" || type == "eqpo":
		sys.player.items.addItem(item)
	elif type == "faci":
		item.cell = sys.mapScene.playFaci.cell
		sys.mapScene.addObj(item)
	elif type == "r" :
		sys.player.relics.addItem(item)
	sys.playSe("BtnChose.wav")

func _on_ItemList_item_selected(index):
	$Control/id.text = ids[index]

func _on_OptionButton_item_selected(index):
	ids.clear()
	list.clear()
	var ts = ["c"]
	if tBtn.text == "单位" :
		ts = ["c"]
	elif tBtn.text == "物品":
		ts = ["m","csb","eqp","gem","eqpo"]
	elif tBtn.text == "神徽" :
		ts = ["r"]
	else:
		ts = ["faci"]
	for t in ts :
		for i in data.getList(t) :
			var item = data.newBase(i.id)
			list.add_item(tr(item.name)+"  "+item.id)
			ids.append(i.id)
