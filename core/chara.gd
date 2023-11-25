extends Conter
class_name Chara

signal onPressed()  #被点击时
signal onHurtStart(atkInfo)  #被伤害前（攻击信息）
signal onHurt(atkInfo)  #被伤害后（攻击信息）
signal onCastHurtStart(atkInfo) #造成伤害前（攻击信息）
signal onCastHurt(atkInfo)  #造成伤害后（攻击信息）
signal onPlus(info)  #回复生命值或护盾（回复信息）
signal onCastPlus(info)  #施放回复生命值或护盾（回复信息）
signal onPlusStart(info)  #回复生命值或护盾（回复信息）
signal onCastPlusStart(info)  #施放回复生命值或护盾（回复信息）

signal onDeathStart(atkInfo) 
signal onDeath(atkInfo)
signal onKillStart(atkInfo)
signal onKill(atkInfo)
signal onCastSkill(skill) #施放主动技能时（施放的技能）
signal onChangeTeam()

signal onSetEqp(item,inx)
signal onChangeEqp(inx1,inx2)
signal onCastBuff(buff)
signal onAddBuff(buff)

signal onPlayAnim(id,spd)
signal onSetDire()
signal onPlusLv()
signal onPlusXp(val)
signal onSetSp(val)
signal onSetAnimFile()
signal onChangeTgUnit()
signal onNormAtk()
signal onAiRanUnit(cha)

signal onRevive()
signal onPlaySe(file,scale)
signal onSetHp()
signal onSetWard()

signal onNewBuffEff(buff)
signal onFire()
signal onUpAnim()

var hp = 0 setget setHp ; 
var ward = 0 setget setWard ;
var reviveVal = 1
func setWard(val):
	ward = val
	if ward < 0 :
		ward = 0
	elif ward > maxHp :
		ward = maxHp
	emit_signal("onSetWard")
func setHp(val):
	hp=val
	if hp < 0 :
		hp = 0
	emit_signal("onSetHp")
var team 
var aiCha = null
var eqps:ItemGrid
var skills:ItemPck = ItemPck.new()
var revBuffs:ItemPck = ItemPck.new()
var varis:ItemPck = ItemPck.new()
var skillIds := []
var isInvin = false
var attBase = {} #基础的属性数值

var upSkills = ItemPck.new()

var yunTime = 0 #眩晕时间
var yingTime = 0 #隐身时间
var normAtkTime = 0  #普通攻击时间
var normAtkS = 1.6
var normEffInx = 0
var skillTime = 0
var skillTimeS = 1
var nowAnim = ""
var animFile = "res://res/anim/p/p1.tres"
var animOffset = Vector2.ZERO
var animScale = Vector2(1.3,1.3)
var animFlip = false
var imgCenterPos = Vector2.ZERO
var attLv = Att.new()  #身板属性 随等级增加
var xp = 0 
var sp = 0 setget setSp; func setSp(val) :
	sp = val ; emit_signal("onSetSp")
var spStup = 2
var maxXp = 20
var baseXp = 60
var maxLv = 6
var price = 2000
var priceId = "m_gold"
var isSummon = false
var isBoss = false
var canMove = true #能否移动
var origin := "" #出身地
var exSkills = ItemPck.new()

func _init():
	lvPerVal = 0.2
	lockVal = 100

func loadInfo(id):
	addAtt(attLv)
	attLv.ran = 1
	attLv.spd = 1.0
	attLv.cdSpd = 1.0
	attLv.cri = 0.1
	attLv.criR = 2.0
	.loadInfo(id)

func _dataEnd():
	for i in cons.upAtt:
		attBase[i] = get(i)
	attBase.ran = ran
	hp = maxHp
	eqps = ItemGrid.new(3)
	for i in skillIds:
		skills.addItem(data.newBase(i))
	upMaxXp()
	if hasTab("战士"):normEffInx = 0
	elif hasTab("射手") :normEffInx = 1
	elif hasTab("坦克") :normEffInx = 0
	elif hasTab("刺客") :normEffInx = 0
	elif hasTab("法师") :normEffInx = 5
	elif hasTab("辅助") :normEffInx = 5
	
func inStart(mas):
	playAnim("idle")
	.inStart(mas)
	for i in eqps.items:
		if i != null :
			addAff(i)
	for i in skills.items:
		addAff(i)
	for i in revBuffs.items:
		addAff(i)
		
func inScene(scene):
	.inScene(scene)
	self.scene = scene
	eqps.connect("onDelItem",self,"rDelItem")
	eqps.connect("onAddItem",self,"rAddItem")
	revBuffs.connect("onAddItem",self,"rAddItem")
	revBuffs.connect("onDelItem",self,"rDelItem")
	skills.connect("onAddItem",self,"rAddItem")
	skills.connect("onDelItem",self,"rDelItem")
	for i in eqps.items :
		addAff(i)
	for i in skills.items:
		addAff(i)
		if i.cd > 0 :
			i.cdVal = i.cd * 0.5
	yingTime = 0.0
	yunTime = 0.0
	normAtkTime = 0.0
	skillTime = 0.0
			
func addAff(base):
	.addAff(base)
	if base != null && base.get("effId") != null :
		emit_signal("onNewBuffEff",base)

func rAddItem(item,inx):
	addAff(item)

var rhp = 0
func rAttSet(id):
	if id == "maxHp":
		rhp = hp / maxHp
	.rAttSet(id)
	if id == "maxHp" :
		self.hp = rhp * maxHp
		
func setSpd(val):
	if val <= 0.1 : val = 0.1
	.setSpd(val)
func setCdSpd(val):
	if val <= 0.1 : val = 0.1
	.setCdSpd(val)

var dire:int = 1 setget setDire
func setDire(val):
	if val == 0 :return
	elif val > 0 :dire = 1
	elif val < 0 :dire = -1
	emit_signal("onSetDire")

func setLv(val):
	for i in attBase:
		attLv[i] = lvPer(val,attBase[i])
	attLv.ran = attBase.ran
	.setLv(val)
	price = 125 * pow(3,lv-1)
	reviveVal = int(lvPer(lv,1,0.5)) 
	
func setEqp(item,inx):
	if item != null && item.wearer != null:
		item.wearer.eqps.delItem(item)
	var itemb = eqps.items[inx]
	eqps.delInxItem(inx)
	var inxItems = -1
	if item != null:
		sys.player.items.delItem(item)
		eqps.addItem(item,inx)
		item.wearer = self
	if itemb != null:
		itemb.wearer = null
		sys.player.items.addItem(itemb)
	sys.playSe("OpenTreasureChest.wav")

func rDelItem(item,inx):
	delAff(item)

func hurtBase(atkInfo):
	if returnCast(): return
	if atkInfo.cha == null || atkInfo.cha.isDeath  || atkInfo.cha.isInvin: return atkInfo
	
	atkInfo.castCha.emit_signal("onCastHurtStart",atkInfo)
	atkInfo.cha.emit_signal("onHurtStart",atkInfo)
	sys.game.emit_signal("onChaCastHurtStart",atkInfo)
	sys.game.emit_signal("onChaHurtStart",atkInfo)
	var defVal = atkInfo.cha.def if atkInfo.hurtType == HURTTYPE.PHY else atkInfo.cha.mdef
	defVal = clamp(defVal - atkInfo.castCha.pen,0,99999) 
	atkInfo.per = clamp((atkInfo.per - 1.0) * cons.perR + 1.0,0.1,10)
	atkInfo.finalPer = clamp((atkInfo.finalPer - 1.0) * cons.perR + 1.0,0.1,20)
	if atkInfo.hurtType == HURTTYPE.REAL:
		atkInfo.finalVal = atkInfo.val * atkInfo.per * atkInfo.finalPer
	else:
		atkInfo.finalVal = atkInfo.val * ( 1 - defVal/(defVal+cons.defCoe) ) * atkInfo.per * atkInfo.finalPer
	if atkInfo.canCri && rndPer(cri) :
		atkInfo.isCri = true
	if atkInfo.isCri :
		atkInfo.finalVal *= criR
	var ward = atkInfo.cha.ward
	ward -= atkInfo.finalVal
	if ward < 0 :
		atkInfo.cha.hp += ward
		atkInfo.cha.ward = 0
	if atkInfo.cha.hp <= 0 :
		atkInfo.finalVal = abs(atkInfo.cha.hp)
		atkInfo.cha.hp = 0
		atkInfo.cha.death(atkInfo)
	atkInfo.cha.ward = ward
	atkInfo.castCha.emit_signal("onCastHurt",atkInfo)
	atkInfo.cha.emit_signal("onHurt",atkInfo)
	sys.game.emit_signal("onChaCastHurt",atkInfo)
	sys.game.emit_signal("onChaHurt",atkInfo)
	return atkInfo
	
func hurt(chara,atkVal,hurtType = HURTTYPE.PHY,atkType = ATKTYPE.SKILL,source = null):
	if source == null: source = self
	var atkInfo = newAtkInfo(chara,atkVal,hurtType,atkType,source)
	return hurtBase(atkInfo)
	
func newAtkInfo(chara,atkVal,hurtType = HURTTYPE.PHY,atkType = ATKTYPE.SKILL,source = null):
	if source == null:source = self
	var atkInfo = {castCha=self,cha=chara,val=atkVal,source=source,atkType=atkType,hurtType=hurtType,per=1.0,finalPer = 1.0,finalVal=0,canCri=false,isCri=false}
	return atkInfo
	
func aiSeekCha(exCha = null):
	var cha = null
	for i in sys.batScene.getAllChas():
		if i == null || i.team == team || i.yingTime > 0 || i.isDeath || i == exCha:continue
		if cha == null :
			cha = i
			continue
		var l1 = distanceTo(i)
		var l2 = distanceTo(cha)
		if l1 < l2 :cha = i 
		elif l1 == l2 && abs(position.y - i.position.y) < abs(position.y - cha.position.y): cha = i
		
	if cha != null : aiCha = cha
	
func death(atkInfo):
	isDeath = true
	emit_signal("onDeathStart",atkInfo)
	atkInfo.castCha.emit_signal("onKillStart",atkInfo)
	sys.game.emit_signal("onChaDeathStart",atkInfo)
	sys.game.emit_signal("onChaKillStart",atkInfo)
	if isDeath :
		emit_signal("onDeath",atkInfo)
		atkInfo.castCha.emit_signal("onKill",atkInfo)
		sys.game.emit_signal("onChaDeath",atkInfo)
		sys.game.emit_signal("onChaKill",atkInfo)
		del()

func del():
	.del()
#	scene.exitMat(self)
#	delEnd()
#	emit_signal("onDel")

func revive(isMaxHp = true):
	isDeath = false
	if isMaxHp :
		plusHp(maxHp)
	playAnim("buff")
	emit_signal("onRevive")

var castNum = 0
func _process(delta):
	castNum = 0
	if yunTime > 0 :yunTime -= delta
	if yingTime > 0 :yingTime -= delta
	if normAtkTime > 0 :normAtkTime -= delta
	if skillTime > 0 : skillTime -= delta
	
func returnCast():
	if castNum < cons.castNumMax :
		castNum += 1
		return false
	return true
	
func atkNorm():
	if (nowAnim == "idle" || nowAnim == "move") && aiCha != null && aiCha.isDeath == false && normAtkTime <= 0:
		normAtkTime = normAtkS / clamp(spd,0.001,100)
		_atkNorm()
		emit_signal("onNormAtk")
		return true
	return false
	
func _atkNorm():
	playAnim("atk",spd)
	yield(ctime(0.3 / spd),"timeout")
	if ran > 1 :
		var eff:Eff = sys.batScene.newEff("e_atk1",position,imgCenterPos)
		eff.get_node("up/img").frame = normEffInx
		eff.flyToChara(aiCha,600)
		eff.connect("onReach",self,"_atkNormR")
		pass
	else:
		_atkNormR()
func _atkNormR():
	var atkInfo = {castCha=self,cha=aiCha,val=atk,source=self,atkType=ATKTYPE.NORMAL,hurtType=HURTTYPE.PHY,per=1.0,finalPer = 1.0,finalVal=0,canCri=true,isCri=false}
	hurtBase(atkInfo)
	
func isNormAnim():
	if nowAnim == "idle" || nowAnim == "move" || nowAnim == "atk":
		return true
	return false
	
func playAnim(id,spd = 1.0):
	if isDeath && nowAnim == "death" :return
	nowAnim = id
	emit_signal("onPlayAnim",id,spd)

func castBuff(cha,bId,lv = 5):
	if returnCast(): return
	var oldBf = cha.hasAff(bId)
	if oldBf != null:
		oldBf.lv += lv
		oldBf.plusLv = lv
		if oldBf.lv > oldBf.maxLv :
			oldBf.lv = oldBf.maxLv
		oldBf.castCha = self
		emit_signal("onCastBuff",oldBf)
		cha.emit_signal("onAddBuff",oldBf)
		sys.game.emit_signal("onChaCastBuff",oldBf)
		sys.game.emit_signal("onChaAddBuff",oldBf)
		return oldBf
	else:
		var bf = data.newBase(bId)
		cha.addAff(bf)
		bf.lv = lv
		bf.plusLv = lv
		bf.castCha = self
		emit_signal("onCastBuff",bf)
		cha.emit_signal("onAddBuff",bf)
		sys.game.emit_signal("onChaCastBuff",bf)
		sys.game.emit_signal("onChaAddBuff",bf)
		return bf
	
func plusHp(val,cha = null,isEff = true,source = null):
	if source == null: source = self
	var info = {castCha=self,cha=cha,val=val,type="hp",source=source,per=1.0,finalPer = 1.0,finalVal=0,canCri=false,isCri=false,isEff=isEff}
	if cha == null: info.cha = self
	plusBase(info)
	
func plusWard(val,cha = null,isEff = true,source = null):
	if source == null: source = self
	var info = {castCha=self,cha=cha,val=val,type="ward",source=source,per=1.0,finalPer = 1.0,finalVal=0,canCri=false,isCri=false,isEff=isEff}
	if cha == null: info.cha = self
	plusBase(info)

func plusBase(info):
	if returnCast(): return
	if info.cha.isDeath :return info
	emit_signal("onCastPlusStart",info)
	info.cha.emit_signal("onPlusStart",info)
	sys.game.emit_signal("onChaCastPlusStart",info)
	sys.game.emit_signal("onChaPlusStart",info)
	info.per = clamp(info.per,0.1,20)
	info.finalPer = clamp(info.finalPer,0.1,20)
	info.finalVal = info.val * info.per * info.finalPer
	if info.type == "hp" :
		info.cha.hp += info.finalVal
		if info.cha.hp > info.cha.maxHp :
			info.finalVal = info.cha.hp - info.cha.maxHp
			info.cha.hp = info.cha.maxHp
	elif info.type == "ward" :
		info.cha.ward += info.finalVal
	if info.isEff && is_instance_valid(scene):
		scene.newEff("e_plusHp",info.cha.position,info.cha.imgCenterPos)
	emit_signal("onCastPlus",info)
	info.cha.emit_signal("onPlus",info)
	sys.game.emit_signal("onChaCastPlus",info)
	sys.game.emit_signal("onChaPlus",info)
	
func castSkill():
	pass
	
func plusLv():
	if lv >= maxLv :return
	plusXp(-maxXp)
	#xp -= maxXp
	self.lv += 1
	self.sp += spStup
	upMaxXp()
	upSkillsReady()
	emit_signal("onPlusLv")
	sys.game.emit_signal("onChaPlusLv",self)
	sys.playSe("LvUp.ogg")
		
func playerPlusLv():
	var dlg = sys.eventDlg.selSkill(upSkills)
	dlg.connect("onSel",self,"skillSel")
	dlg.reUpBtn.link(5,self,"upSkillsReady")
	
func skillSel(skill):
	if skill != null:
		skills.addItem(skill)
		sys.player.subItem("m_xp",maxXp)
		plusLv()
	
func aiPlusLv():
	plusLv()
	var skill = data.newBase(rnp.skillPool.rndItem(self,"rnfSkill").id)
	skills.addItem(skill)

func rnfSkill(skill):
	if skill.hasOrTab(tab) == false: return false
	for i in skills.items:
		if i.id == skill.id :
			return false
	return true

func plusXp(val):
	if lv >= maxLv :return
	xp += val
	var bl = false
	emit_signal("onPlusXp",val)
	return bl

func upMaxXp():
	maxXp = baseXp * pow(3,lv-1)

func upSkillsReady():
	if team != sys.player.team :return
	upSkills.clear()
	for i in sys.player.upSkillNum :
		var k = rnp.skillPool.rndItem(self,"upSKillsRnf")
		if k != null:upSkills.addItem(data.newBase(k.id))
	return upSkills

func upSKillsRnf(vari):
	if vari.hasOrTab(tab) == false: return false
	for i in skills.items:
		if i.id == vari.id :
			return false
	for i in upSkills.items:
		if i.id == vari.id :
			return false
	return true

func getPow():
	return lvPer(lv,10)

func getDec():
	var txt = """[b][color={lvColor}]{name}[/color][/b]
{tab}
{ori}
"""
	for i in skills.items:
		txt += "\n[color=%s]%s[/color]" % [cons.colorDs.lvs[i.lv-1],tr(i.name)]
	return "[center]%s[/center]" % txt.format({name=tr(name),tab=trTab(),ori=tr("获取： ")+trOrigin(),lvColor=cons.colorDs.lvs[lv-1]})
#召唤一个目标id的单位
func summ(id,cell = null):
	if cell == null: cell = self.cell
	var cha = data.newBase(id)
	cha.team = team
	cha.isSummon = true
	cha.lv = lv
	if sys.batScene.addObj(cha,cell) :
		if is_instance_valid(cha.vis) :
			cha.vis.setProcess(sys.batScene.isBattle)
		return cha
#召唤一个目标的克隆体(对象，位置，减伤等级)
func summCopy(ccha,cell=null,dlv = 0):
	var cha = summ(ccha.id,cell)
	cha.lv = lv
	for i in range(skills.items.size()):
		if i == 0 :continue
		var ok = skills.items[i]
		var k = data.newBase(ok.id)
		k.lv = ok.lv
		cha.skills.addItem(k)
	for i in eqps.items:
		if i == null : continue
		var e = data.newBase(i.id)
		e.lv = i.lv
		for j in i.gems.items:
			var gem = data.newBase(j.id)
			gem.lv = j.lv
			e.gems.addItem(gem)
		cha.eqps.addItem(e)
	if cha != null && dlv > 0 :
		cha.castBuff(cha,"b_b_cuiRuo",dlv)
	return cha

func delAllAff():
	.delAllAff()
	for i in range(atts.size()-1,-1,-1):
		if atts[i] != attLv :
			delAtt(atts[i])
			
func fire():
	for i in eqps.items.size():
		setEqp(null,i)
	sys.player.team.delCha(self)
	if is_instance_valid(vis) :
		vis.isDeathDel = true
	del()
	emit_signal("onFire")
	sys.game.emit_signal("onChaFire",self)

func upLv(sel):
	pass
#取最虚弱单位 (0：全部 1：敌人 2：友军)
func getWeakCha(type = 1):
	var cha = null
	for i in sys.batScene.getAllChas():
		if type == 1 && i.team == team:continue
		elif type == 2 && i.team != team :continue
		if cha == null:
			cha = i
			continue
		if cha.hp/cha.maxHp > i.hp/i.maxHp :
			cha = i
	return cha
#取最血量最低单位 (0：全部 1：敌人 2：友军)
func getMinHpCha(type = 1):
	var cha = null
	for i in sys.batScene.getAllChas():
		if type == 1 && i.team == team:continue
		elif type == 2 && i.team != team :continue
		if cha == null:
			cha = i
			continue
		if cha.hp > i.hp :
			cha = i
	return cha
#取最血量最高单位 (0：全部 1：敌人 2：友军)
func getMaxHpCha(type = 1):
	var cha = null
	for i in sys.batScene.getAllChas():
		if type == 1 && i.team == team:continue
		elif type == 2 && i.team != team :continue
		if cha == null:
			cha = i
			continue
		if cha.hp < i.hp :
			cha = i
	return cha
#取属性最高单位（属性id，0：全部 1：敌人 2：友军）
func getMaxAttCha(id,type = 1):
	var cha = null
	for i in sys.batScene.getAllChas():
		if type == 1 && i.team == team:continue
		elif type == 2 && i.team != team :continue
		if cha == null || i[id]> cha[id] :
			cha = i 
	return cha
#取属性最低单位（属性id，0：全部 1：敌人 2：友军）
func getMinAttCha(id,type = 1):
	var cha = null
	for i in sys.batScene.getAllChas():
		if type == 1 && i.team == team:continue
		elif type == 2 && i.team != team :continue
		if cha == null || i[id] < cha[id] :
			cha = i 
	return cha
#取最近单位组（0：全部 1：敌人 2：友军 ， 数量）
func getMinRanChas(type = 1,n = 3):
	var chas = []
	for i in range(1,8):
		for j in sys.batScene.getRing(cell,i) :
			var cha = sys.batScene.matObj(j)
			if cha == null : continue
			if type == 1 && cha.team == team:continue
			elif type == 2 && cha.team != team :continue
			elif cha == self :continue
			chas.append(cha)
			n -= 1
			if n <0 : 
				return chas
	return chas 
#取最近单位（0：全部 1：敌人 2：友军）
func getMinRanCha(type = 1):
	var cha = null
	for i in sys.batScene.getAllChas() :
		if i == null : continue
		if type == 1 && i.team == team:continue
		elif type == 2 && i.team != team :continue
		if i == self :continue
		if cha == null :
			cha = i
			continue
		if distanceTo(i) < distanceTo(cha) :
			cha = i
	return cha
#取最远单位（0：全部 1：敌人 2：友军）
func getMaxRanCha(type = 1):
	var cha = null
	for i in sys.batScene.getAllChas() :
		if i == null : continue
		if type == 1 && i.team == team:continue
		elif type == 2 && i.team != team :continue
		if i == self :continue
		if cha == null :
			cha = i
			continue
		if distanceTo(i) > distanceTo(cha) :
			cha = i
	return cha
#给予对应职业的随机装备（装备等级）
func addRndItem(lv):
	var item = data.newBase(rnp.eqpPool.rndItem(self,"addRndItemF").id)
	item.create(lv)
	for i in range(eqps.items.size()):
		if eqps.items[i] == null :
			setEqp(item,i)
			
func addRndItemF(item):
	if item.hasOrTab(tab) :
		return true
	return false
#返回副职业
func getProfession():
	var s = tab.split(" ")
	if s.size() > 1:return s[1]
	else:return ""
#返回主职业
func getOrientation():
	var s = tab.split(" ")
	if s.size() > 0:return s[0]
	else:return ""
	
func trOrigin():
	var t = ""
	for i in origin.split(" "):
		t += tr(i) + " "
	return t
	
func upAnim():
	emit_signal("onUpAnim")

func getSave():
	var ds = {
		hp = hp,
		isDeath = isDeath,
		sp = sp,
		isBoss = isBoss,
		eqps = eqps.getSave(),
		skills = skills.getSave(),
		upSkills = upSkills.getSave(),
		exSkills = exSkills.getSave(),
	}
	ds.merge(.getSave())
	return ds

func setSave(ds):
	.setSave(ds)
	dsSet("hp",ds)
	dsSet("isDeath",ds)
	dsSet("sp",ds)
	dsSet("isBoss",ds)
	upMaxXp()
	eqps = ItemGrid.new().setSave(ds.eqps)
	skills = ItemPck.new().setSave(ds.skills)
	upSkills = ItemPck.new().setSave(ds.upSkills)
	exSkills = ItemPck.new().setSave(ds.exSkills)
	for i in eqps.items:
		if i != null :
			i.wearer = self
