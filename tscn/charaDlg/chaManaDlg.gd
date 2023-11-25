extends BasePopup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lv = 0
var popl = 0
onready var itemBox = $eqp/ScrollContainer/box
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(player):
	$batScene.initPlayer(player)
	$batScene.connect("onSetMatObj",self,"upInfo")
	upInfo(null,null)
	sys.player.items.connect("onAddItem",self,"rAddItem")
	for i in sys.player.items.items:
		rAddItem(i,-1)
	sys.addTip($Label/popl,"战力等级提升时，将提高人口上限")
	sys.addTip($Label/lv,"战力等级随单位的总等级而提高")
	sys.player.itemSort()
	for j in range(sys.player.items.items.size()-1,-1,-1) :
		var i = sys.player.items.items[j]
		if i is Mater && i.isHomeShow:
			var mi = load("res://tscn/item/itemBtn.tscn").instance()
			$m/box.add_child(mi)
			mi.init(i)
			
	sys.player.connect("onUpLv",self,"rUpLv")
	$batScene.connect("onChaMove",self,"rChaMove")
	sys.mapScene.connect("onBat",self,"_bat")
	if sys.game.globals.has("g_game") :
		$jtip.visible = sys.game.diffLv == 0 && sys.game.globals.g_game.jtip == 0
	
func rUpLv():
	upInfo(null,null)
	
func rChaMove():
	sys.player.upBatLv()

func rAddItem(item,inx):
	if item is Eqp:
		var itemBt = load("res://tscn/charaDlg/eqplBtn.tscn").instance()
		itemBox.add_child(itemBt)
		itemBt.init(item)
	#	itemBt.connect("pressed",item,"use")
		itemBt.isInfo = false
		
func _bat():
	queue_free()

func _on_Button_pressed():
	del()

func upInfo(cell,cha):
	popl = 0
	for i in sys.player.team.chas:
		if i.cell.x < 5:
			popl += 1
	$Label/popl/lab.text = "%d/%d" % [popl,sys.player.maxPopl]
	$Label/lv/lab.text = "%d" % [sys.player.lv]

func _on_btnUpPop_pressed():
	sys.player.plusPopl()
	upInfo(null,null)

func del():
	.del()
	sys.player.emit_signal("upChas")
	if sys.game.globals.has("g_game") :
		sys.game.globals.g_game.jtip = 1
	sys.player.upBatLv()

func _on_eqpUp_pressed():
	pass # Replace with function body.
