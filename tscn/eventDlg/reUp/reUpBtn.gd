extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal onReUp()

var num = 0
var obj 
var reF
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func link(num,obj,reF):
	if num <= 0 :
		$Label.hide()
		$TextureRect.hide()
	else:
		$Label.text = str(num)
		self.num = num
	self.obj = obj
	self.reF = reF
	show()

func _on_reUpBtn_pressed():
	if sys.player.subItem("m_cry",num) :
		emit_signal("onReUp")
		get_parent().init(obj.call(reF))
	else:
		sys.newMsg("晶石 不足")
		
