extends "res://tscn/eventDlg/eventBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(txt,isNext = false):
	$RichTextLabel.bbcode_text = tr(txt)
	if isNext :
		_on_Button_pressed()

func _on_Button_pressed():
	if noPre():return
	$Button.hide()
	emit_signal("onSel",null)
