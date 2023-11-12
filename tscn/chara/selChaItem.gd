extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cha 

# Called when the node enters the scene tree for the first time.
func init(cha):
	self.cha = cha
	$charaItem.init(cha)

func _on_Button_pressed():
	pass # Replace with function body.
