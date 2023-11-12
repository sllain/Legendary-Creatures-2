extends BasePopup
class_name BaseDlg

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tile = $bg/NinePatchRect/tile


func setTile(val):
	tile.text = val


func _on_closeBtn_pressed():
	del()

func txt(txt):
	$txt.bbcode_text = txt

func _on_baseDlg_about_to_show():
	pass

