extends NinePatchRect

signal onBuy(item)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var item 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(item):
	self.item = item
	$charaItem.init(item)
	$Button.text = "%d" % item.price
	$Button.icon = data.newRes("ico_%s" % item.priceId)
 
func _on_Button_pressed():
	if sys.player.subItem(item.priceId,item.price) :
		sys.player.addAlterCha(item)
		queue_free()
		sys.playSe("JumpDown.wav")
		emit_signal("onBuy",item)
	else:
		sys.newMsg(tr("%s 不足") % [tr(data.newBase(item.priceId).name)])
	pass # Replace with function body.
