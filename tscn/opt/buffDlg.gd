extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in data.getList("b") :
		var b = data.newBase(i.id)
		if b.lock == -1 :continue
		var bt = preload("res://tscn/charaDlg/buffBtn.tscn").instance()
		$HFlowContainer.add_child(bt)
		bt.init(b)
	var ss = [
		"状态时长：每秒减少5层，层数越高减的越快，最高70层",
		"",
		"攻击类型",
		"普攻：如非特殊标注视为普攻或者触发攻击特效的技能为该类型，但无法暴击",
		"技能：如非特殊标注，主动技能为该类型",
		"被动：如非特殊标注，被动技能和其他效果为该类型",
		"",
		"伤害类型：物理，魔法，真实",
		"真实伤害不受护甲影响，但受增减伤影响",
	]
	for i in ss:
		$RichTextLabel.text += tr(i) + "\n"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

