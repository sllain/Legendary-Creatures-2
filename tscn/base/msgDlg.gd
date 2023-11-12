extends BaseDlg

signal onSel(isOk)
var isOk = false

func init(txt,isSel = false):
	txt(txt)
	$HBoxContainer.visible = isSel


func _on_Button_pressed():
	isOk = true
	del()

func _on_Button2_pressed():
	del()

func del():
	emit_signal("onSel",isOk)
	.del()
