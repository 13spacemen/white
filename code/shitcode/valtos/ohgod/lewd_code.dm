/mob/var/lastmoan

/mob/proc/moan()

	if(!(prob(lust / lust_tolerance * 65)))
		return

	var/moan = rand(1, 7)
	if (moan == lastmoan)
		moan--
	lastmoan = moan

	visible_message("<font color=purple> <b>[src]</b> [pick("������", "������ � �����������",)].</font>")

	if (gender == FEMALE && prob(25))
		playsound(get_turf(src), "code/shitcode/valtos/sounds/love/shot[rand(1, 8)].ogg", 90, 1, 0)
	else
		playsound(get_turf(src), "code/shitcode/valtos/ohgod/sounds/interactions/moan_[gender == FEMALE ? "f" : "m"][moan].ogg", 70, 1, 0)

/mob/proc/cum(var/mob/living/carbon/partner, var/target_orifice)

	var/message
	if(has_penis())

		if(!istype(partner))
			target_orifice = null

		switch(target_orifice)
			if(CUM_TARGET_MOUTH)
				if(partner.has_mouth() && partner.mouth_is_free())
					message = pick("���������� ����� � ��� [partner].","������� �� ������ [partner].","�������� ��������� � ��� [partner].","��������� ��� [partner] ���������.","������� ���������� � ��� [partner], ���, ��� ������� ��� ���.","��������� � ����� [partner] ������ ������� �������")
					partner.reagents.add_reagent("cum", 10)
				else
					message = "���������� �� ���� [partner]."
			if(CUM_TARGET_THROAT)
				if(partner.has_mouth() && partner.mouth_is_free())
					message = "������� ���� ����-����� ��� ����� ������ � ������ [partner] � ����������."
					partner.reagents.add_reagent("cum", 15)
				else
					message = "���������� �� ���� [partner]."
			if(CUM_TARGET_VAGINA)
				if(partner.is_nude() && partner.has_vagina())
					message = "���������� � ��������� [partner]."
				else
					message = "���������� �� �������[partner]."
			if(CUM_TARGET_ANUS)
				if(partner.is_nude() && partner.has_anus())
					message = "���������� � ���������� [partner]."
				else
					message = "���������� �� ������ [partner]."
			if(CUM_TARGET_HAND)
				if(partner.has_hand())
					message = "���������� � ���� [partner]."
				else
					message = "���������� �� [partner]."
			if(CUM_TARGET_BREASTS)
				if(partner.is_nude() && partner.has_vagina())
					message = "���������� �� ����� [partner]."
				else
					message = "���������� �� ��� � ����� [partner]."
			if(NUTS_TO_FACE)
				if(partner.has_mouth() && partner.mouth_is_free())
					message = "������� ���������� [partner] ������ ������� � ��������."
			if(THIGH_SMOTHERING)
				if(partner.has_mouth())
					message = "���������� [partner] � ����� ������� ������� �� ����� ���������, ������� �������� ���� �����������."
			else
				message = "������� �� ��� ��������!"

		lust = 5
		lust_tolerance += 50

	else
		message = pick("���������� ����� � ����� ������", "�������� � ��������������.","��������, ������� �����","�����������, � ����� ����� �������������","���������� � �������� �������")
		lust -= pick(10, 15, 20, 25)

	if(gender == MALE)
		if (prob(75))
			playsound(loc, "code/shitcode/valtos/ohgod/sounds/interactions/final_m[rand(1, 3)].ogg", 90, 1, 0)
		else
			playsound(loc, "code/shitcode/valtos/sounds/gachi/penetration_[rand(1, 2)].ogg", 90, 1, 0)
	else if(gender == FEMALE)
		if (prob(75))
			playsound(loc, "code/shitcode/valtos/ohgod/sounds/interactions/final_f[rand(1, 5)].ogg", 70, 1, 0)
		else
			playsound(loc, "code/shitcode/valtos/sounds/love/shot9.ogg", 90, 1, 0)

	visible_message("<font color=purple><b>[src]</b> [message]</font>")

	new /obj/effect/decal/cleanable/cum(src.loc)

	multiorgasms += 1
	if(multiorgasms == 1)
		log_combat(partner, src, "came on")

	if(multiorgasms > (sexual_potency/3))
		refactory_period = 100 //sex cooldown
		adjust_drugginess(35)
	else
		refactory_period = 100
		adjust_drugginess(12)

/mob/var/last_partner
/mob/var/last_orifice

/mob/proc/is_fucking(var/mob/living/carbon/partner, var/orifice)
	if(partner == last_partner && orifice == last_orifice)
		return 1
	return 0

/mob/proc/set_is_fucking(var/mob/living/carbon/partner, var/orifice)
	last_partner = partner
	last_orifice = orifice

/mob/living/carbon/proc/do_sex(var/mob/living/carbon/partner, var/action_to_do) // ����� ����� ������ � ������ �����
	var/message
	var/lust_increase = 0
	var/c_target = null
	var/stp

	switch(action_to_do)
		if ("do_oral")
			lust_increase = 10
			c_target = CUM_TARGET_MOUTH
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/bj[rand(1, 11)].ogg"
			if(partner.is_fucking(src, CUM_TARGET_MOUTH))
				if(prob(partner.sexual_potency))
					message = "���������� ������ � ��������� [partner]."
					lust_increase += 5
				else
					if(partner.has_vagina())
						message = "����� ��������� [partner]."
					else if(partner.has_penis())
						message = "���������� ����-����� [partner]."
					else
						message = "����� ����-����� [partner]."
			else
				if(partner.has_vagina())
					message = "����������� ����� � ������ [partner]."
				else if(partner.has_penis())
					message = "���� ����-����� [partner] � ���� �����."
				else
					message = "����������� ������ ����-����� [partner]."
				partner.set_is_fucking(src, CUM_TARGET_MOUTH)

		if ("do_facefuck")
			lust_increase = 10
			c_target = CUM_TARGET_MOUTH
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/oral[rand(1, 2)].ogg"
			if(is_fucking(partner, CUM_TARGET_MOUTH))
				if(has_vagina())
					message = "������ ����� ���������� �� ���� [partner]."
				else if(has_penis())
					message = pick("����� ��������� [partner] � ���.","������ ��������� ������ [partner] � ����.")
			else
				if(has_vagina())
					message = "������ [partner] ����� � ���� ���������."
				else if(has_penis())
					if(is_fucking(partner, CUM_TARGET_THROAT))
						message = "������ ���� ����-����� �� ������� [partner]"
					else
						message = "����������� ���� ����-����� ��� ������ � ������� [partner]"
				else
					message = "������ ���������� �� ���� [partner]."
				set_is_fucking(partner, CUM_TARGET_MOUTH)

		if ("do_throatfuck")
			lust_increase = 10
			c_target = CUM_TARGET_MOUTH
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/oral[rand(1, 2)].ogg"
			if(is_fucking(partner, CUM_TARGET_THROAT))
				message = "[pick(list("���������� ������ ����� ��� � ������� [partner].", "����� ������� � ������� [partner]."))]</span>"
				if(rand(3) == 1) // 33%
					partner.emote("���������� � ������� [src]")
					partner.adjustOxyLoss(1)
			else if(is_fucking(partner, CUM_TARGET_MOUTH))
				message = "��� ����-����� ������, ������ ��� � ������� [partner]."

			else
				message = "����� ���������� ���� ����-����� � ������� [partner]"
				set_is_fucking(partner , CUM_TARGET_THROAT)

		if ("do_anal")
			lust_increase = 10
			c_target = CUM_TARGET_ANUS
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/bang[rand(1, 3)].ogg"
			if(is_fucking(partner, CUM_TARGET_ANUS))
				message = pick("��������� [partner] � �����������.","����� ��������� ������ [partner]","��������� ����-����� � ����������� [partner] �� ����� ������.")
			else
				message = "����������� ��������� ����������� [partner]."
				set_is_fucking(partner, CUM_TARGET_ANUS)

		if ("do_vaginal")
			lust_increase = 10
			c_target = CUM_TARGET_VAGINA
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/champ[rand(1, 2)].ogg"
			if(is_fucking(partner, CUM_TARGET_VAGINA))
				message = "��������� � ��������� [partner]."
			else
				message = "������ ��������� ����������� ������ [partner]"
				set_is_fucking(partner, CUM_TARGET_VAGINA)

		if ("do_mount")
			lust_increase = 10
			c_target = CUM_TARGET_VAGINA
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/bang[rand(1, 3)].ogg"
			if(partner.is_fucking(src, CUM_TARGET_VAGINA))
				message = "������ �� ����-������ [partner]."
			else
				message = "���������� ���� ��������� �� ����-����� [partner]."
				partner.set_is_fucking(src, CUM_TARGET_VAGINA)

		if ("do_mountass")
			lust_increase = 10
			c_target = CUM_TARGET_ANUS
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/bang[rand(1, 3)].ogg"
			if(partner.is_fucking(src, CUM_TARGET_ANUS))
				message = "������ �� ����-������ [partner]."
			else
				message = "�������� ���� ��� �� ����-����� [partner]."
				partner.set_is_fucking(src, CUM_TARGET_ANUS)

		if ("do_fingering")
			lust_increase = 10
			c_target = null
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/champ_fingering.ogg"
			visible_message("<b>[src]<b> [pick(list("����������� ��������� [partner].", "�������� ������� ��������� [partner].", "��������� �� ��������� ��������� [partner]."))]</span>")

		if ("do_fingerass")
			lust_increase = 10
			c_target = null
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/champ_fingering.ogg"
			visible_message("<b>[src]<b> [pick(list("����������� ����������� [partner].", "�������� ������� �������� [partner].", "��������� �� ��������� ������ ������ [partner]."))]</span>")

		if ("do_rimjob")
			lust_increase = 10
			c_target = null
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/champ_fingering.ogg"
			visible_message("<b>[src]<b> ���������� ���� �� ������ ����� [partner].</span>")

		if ("do_handjob")
			lust_increase = 10
			c_target = CUM_TARGET_HAND
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/bang[rand(1, 3)].ogg"
			if(partner.is_fucking(src, CUM_TARGET_HAND))
				message = "[pick(list("������� [partner].", "�������� ����� � �������� ����-������ [partner].", "�������� � ��������� ����-����� [partner] �������."))]"
			else
				message = "����� ����������� ����-����� [partner] �����."
				partner.set_is_fucking(src, CUM_TARGET_HAND)

		if ("do_breastfuck")
			lust_increase = 10
			c_target = CUM_TARGET_BREASTS
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/bang[rand(1, 3)].ogg"
			if(is_fucking(partner, CUM_TARGET_BREASTS))
				message = "[pick(list("��������� [partner] ����� �����.", "������������� � [partner] ����� �����."))]"
			else
				message = "���� ����� [partner] ����� � ������� � ��������� ��� ���� ����-�����."
				set_is_fucking(partner , CUM_TARGET_BREASTS)

		if ("do_mountface")
			lust_increase = 1
			c_target = null
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/squelch[rand(1, 3)].ogg"
			if(is_fucking(partner, GRINDING_FACE_WITH_ANUS))
				message = "[pick(list("������ ��������� [partner]", "��� �������� ������� [partner]."))]</span>"
			else
				message = "[pick(list("�����, ��� [partner] ������� � ������ ����������� ������� ��������� ���.", "����� ��������� [partner] ���������."))]</span>"
				set_is_fucking(partner , GRINDING_FACE_WITH_ANUS)
	
		if ("do_grindface")
			lust_increase = 1
			c_target = null
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/foot_dry[rand(1, 4)].ogg"
			if(is_fucking(partner, GRINDING_FACE_WITH_FEET))
				if(src.get_item_by_slot(SLOT_SHOES) != null)
					message = "[pick(list("�������� [get_shoes()] �������� �� ���� [partner].", "�������� ���� [get_shoes()] �� ���� [partner] � ����������� ���.", "����� ����� [get_shoes()] �� ���� [partner]."))]</span>"
				else
					message = "[pick(list("������ ���� �������� ���� �� ���� [partner].", "�������� ���� ��������� ������ �� ���� [partner], � ��� ��� ���.", "���������� ���� �� ���� [partner]."))]</span>"
				set_is_fucking(partner , GRINDING_FACE_WITH_FEET)

		if ("do_grindmouth")
			lust_increase = 1
			c_target = null
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/foot_wet[rand(1, 3)].ogg"
			if(is_fucking(partner, GRINDING_MOUTH_WITH_FEET))
				if(src.get_item_by_slot(SLOT_SHOES) != null)
					message = "[pick(list("���������� [partner] ����������� [get_shoes()].", "��� ������� ����� � [get_shoes()] [partner]."))]</span>"
				else
					message = "[pick(list("���������� [partner] ����������� ���� ������� ����� �� ����.", "���������� [partner] ������� ������.", "���������� ��� � ��� [partner] ������, ����� ��� ���� [partner] ���������� � ����� ��������� ������."))]</span>"
				set_is_fucking(partner , GRINDING_MOUTH_WITH_FEET)

		if ("do_nuts")
			lust_increase = 1
			c_target = CUM_TARGET_MOUTH
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/nuts[rand(1, 4)].ogg"
			if(is_fucking(partner, NUTS_TO_FACE))
				message = pick(list("������� [partner] �� ������ � ���������� ������� �������.", "������� [partner] ����������� ��� ������ ������������ �������.", "������� ����������� ������� [partner] ��������.", "����������� �� ��, ��� [partner] �� ������ � ��� ���� ��� ��������� �������."))
			else
				message = pick(list("�����, ��� [partner] ����� ������� � ������ ��������� ��� ��������!", "����� � ���������� �� ���� [partner] ����� � ����� �������, ����� ����� ��������� � ��� [partner] �������������� �������."))
				set_is_fucking(partner , NUTS_TO_FACE)

		if ("do_thighs")
			lust_increase = 10
			c_target = THIGH_SMOTHERING
			var file = pick(list("bj10", "bj3", "foot_wet1", "foot_dry3"))
			stp = "code/shitcode/valtos/ohgod/sounds/interactions/[file].ogg"
			if(is_fucking(partner, THIGH_SMOTHERING))
				if(has_vagina())
					message = pick(list("���� � ��� ����� ������� ������ ������ ������ [partner] �������� ��� ����� �������.", "����������� ������ [partner] ������ ��������� ������� ���������."))
				else if(has_penis())
					message = pick(list("���� � ��� ����� ������� ������ ������ ������ [partner] �������� ��� ����� �������.", "����������� ������ [partner] ������ ��� ������� � �������� �������� ������� ��������.", "��������� ����� �������� � ����������� ��� [partner], ��������� ��� ���� ������ �������� �����."))
				else
					message = "����������� ������ [partner] ������."
			else
				message = pick(list("�������� �� ����� [partner] � ���� � ������ ������ ������ ������.", "������� ������ [partner] ������."))
				set_is_fucking(partner , THIGH_SMOTHERING)
			partner.adjustOxyLoss(1)

	if (message)
		visible_message("<b>[src]</b> [message]")
	if (stp)
		playsound(get_turf(src), stp, 50, 1, -1)
	handle_post_sex(lust_increase, c_target, partner)
	partner.handle_post_sex(lust_increase, c_target, src)
	partner.dir = get_dir(partner,src)
	do_fucking_animation(get_dir(src, partner))

/mob/proc/get_shoes()
	var/obj/A = get_item_by_slot(SLOT_SHOES)
	if(findtext (A.name,"the"))
		return copytext(A.name, 3, (lentext(A.name)) + 1)
	else
		return A.name

/mob/proc/handle_post_sex(var/amount, var/orifice, var/mob/partner)

	sleep(5)

	if(stat != CONSCIOUS)
		return
	if(amount)
		lust += amount
	if (lust >= lust_tolerance)
		cum(partner, orifice)
	else
		moan()

/obj/item/dildo
	name = "dildo"
	desc = "������."
	icon = 'code/shitcode/valtos/ohgod/icons/samurai.dmi'
	icon_state = "dildo"
	item_state = "c_tube"
	throwforce = 0
	force = 1000
	w_class = 1
	throw_speed = 3
	throw_range = 15
	attack_verb = list("�������")

	var/hole = CUM_TARGET_VAGINA
	var/pleasure = 5

/obj/item/dildo/Initialize()
	. = ..()
	force = rand(100,1000)
	desc = "��������������� ������ �������� ������ <b>[force]</b>."

/obj/item/dildo/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	var/message = ""
	if(istype(M, /mob/living/carbon/human) && user.zone_selected == "groin" && M.is_nude())
		if (hole == CUM_TARGET_VAGINA && M.has_vagina())
			message = (user == M) ?  "fucks their own pussy with \the [src]" : pick(list("fucks [M] right in the pussy with \the [src]", "jams \the [src] right into [M]"))
		else if (hole == CUM_TARGET_ANUS && M.has_anus())
			message = (user == M) ? "fucks their own ass with \the [src]" : "fucks [M]'s asshole with \the [src]"
	if(message)
		user.visible_message("<font color=purple>[user] [message].</font>")
		M.handle_post_sex(pleasure, null, user)
		playsound(loc, "code/shitcode/valtos/ohgod/sounds/interactions/bang[rand(4, 6)].ogg", 70, 1, -1)
	else
		return ..()

/obj/item/dildo/attack_self(mob/user as mob)
	if(hole == CUM_TARGET_VAGINA)
		hole = CUM_TARGET_ANUS
	else
		hole = CUM_TARGET_VAGINA
	user << "<span class='warning'>Hmmm. Maybe we should put it in \a [hole]?</span>"