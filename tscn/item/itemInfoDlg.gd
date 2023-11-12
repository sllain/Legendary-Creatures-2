extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal onP(inx)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(item,txt,isCon = false):
	$txt.bbcode_text = txt
	$con.visible = isCon
	if item != null && item.wearer != null :
		if item.wearer.team != sys.player.team : 
			$con.hide()
		if item.wearer.isSummon : 
			$con.hide()
	else:$con.hide()
	
func _on_Button_pressed():
	emit_signal("onP",0)
	del()

func _on_Button2_pressed():
	emit_signal("onP",1)
	del()
