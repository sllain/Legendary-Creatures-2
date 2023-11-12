extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	if sys.isTest == false:
		$VBoxContainer/test.hide()
	if sys.isDemo :
		$VBoxContainer/book.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	sys.newDlg("res://tscn/opt/buffDlg.tscn")

func _on_Button2_pressed():
	sys.game.saveGame()
	sys.main.delGame()

func _on_end_pressed():
	queue_free()
	sys.game.end(false)

func _on_test_pressed():
	sys.newDlg("res://tscn/game/testDlg.tscn")

func _on_book_pressed():
	sys.newDlg("res://tscn/book/bookDlg.tscn")

func _on_sheZhi_pressed():
	sys.newDlg("res://tscn/tile/sheZhi.tscn")
