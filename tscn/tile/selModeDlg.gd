extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$VBoxContainer/m1/RichTextLabel.bbcode_text = tr("在大地图上自由的探索，找到并击败最终的魔王获得胜利！")
	$VBoxContainer/m2/RichTextLabel.bbcode_text = tr("一层层推进，更快的节奏，更直接简单的模式。")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	var dlg = sys.newDlg("res://tscn/tile/newGameDlg.tscn")
	pass # Replace with function body.


func _on_Button2_pressed():
	var dlg = sys.newDlg("res://tscn/tile/newGameTowerDlg.tscn")
