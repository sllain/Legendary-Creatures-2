extends Node

const attDs = {
	maxHp={name="最大生命值",dec="决定生命上限",isPer=false,rt=100},
	atk={name="物理攻击",dec="提升普通攻击和物理伤害",isPer=false,rt=6},
	matk={name="魔法攻击",dec="大幅提升魔法伤害",isPer=false,rt=9},
	def={name="物理防御",dec="减少物理伤害",isPer=false,rt=10},
	mdef={name="魔法防御",dec="减少魔法伤害",isPer=false,rt=10},
	pen={name="穿甲",dec="无视一部分物理和魔法防御",isPer=false,rt=5},
	ran={name="射程",dec="攻击范围",isPer=false,rt=1},
	cri={name="暴击率",dec="普通攻击的暴击率",isPer=true,rt=0.05},
	criR={name="暴击伤害",dec="暴击时造成的伤害倍率",isPer=true,rt=0.05},
	spd={name="攻速",dec="普通攻击的速度",isPer=true,rt=0.075},
	cdSpd={name="冷却速度",dec="主动技能的冷却速度",isPer=true,rt=0.075},
	#matkp={name="",dec="",isPer=false,rt=5},
}
const defCoe = 100.0
const perR = 0.6
const upAtt = ["maxHp","atk","def","matk","mdef"]
const ctAtt = ["ct1","ct2","ct3","ct4","ct5"]

const colorDs = {
	att="#99dd99",
	lvs = ["#dadada","#88abfe","#e883f6","#ff9a0c","#ff4444","#88ff99","#ffffff","#ffffff"]
}

const lvStr = ["普通","卓越","史诗","传奇","远古","神话","宇宙","宇宙"]

const tipDs = {
}

const priceRatio = 0.3
const castNumMax = 50

func init():
	tipDs.clear()
	for i in data.getList("b"):
		var bf = data.newBase(i.id)
		if bf.lock == 1 :
			tipDs[bf.name] = bf.dec

const chaAttDs = {
	1:{
		ran = 1,
		atk = 9,
		matk = 5,
		def = 5,
		mdef = 5,
		maxHp = 10,
	},
	2 : {
		ran = 4,
		atk = 9,
		matk = 5,
		def = 4,
		mdef = 4,
		maxHp = 7,
	},
	3: {
		ran = 1,
		atk = 7,
		def = 5,
		matk = 5,
		mdef = 5,
		maxHp = 10,
	},
	4 : {
		ran = 1,
		atk = 8,
		matk = 5,
		def = 4,
		mdef = 4,
		maxHp = 9,
	},
	5 : {
		ran = 3,
		atk = 6,
		def = 3,
		matk = 7,
		mdef = 4,
		maxHp = 6,
	},
	6 :  {
		ran = 3,
		atk = 7,
		def = 4,
		matk = 7,
		mdef = 4,
		maxHp = 7,
	}
}
