/mob/living/carbon/examine(mob/user)
	var/t_on 	= ru_who(TRUE)
	var/t_ego 	= ru_ego()
	//var/t_na 	= ru_na()
	var/t_a 	= ru_a()

	. = list("<span class='info'>*---------*\n��� �� [icon2html(src, user)] \a <EM>[src]</EM>!")
	var/list/obscured = check_obscured_slots()

	if (handcuffed)
		. += "<span class='warning'>[t_on] [icon2html(handcuffed, user)] � ����������!</span>"
	if (head)
		. += "�� ������ � �[t_ego] [head.ru_get_examine_string(user)]."
	if(wear_mask && !(SLOT_WEAR_MASK in obscured))
		. += "�� [t_ego] ���� [wear_mask.ru_get_examine_string(user)]."
	if(wear_neck && !(SLOT_NECK in obscured))
		. += "�� ��� � �[t_ego] [wear_neck.ru_get_examine_string(user)]."

	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT))
			. += "� [t_ego] [get_held_index_name(get_held_index_of_item(I))] ��[t_a] ������ [I.ru_get_examine_string(user)]."

	if (back)
		. += "�� [t_ego] ����� [back.ru_get_examine_string(user)]."
	var/appears_dead = 0
	if (stat == DEAD)
		appears_dead = 1
		if(getorgan(/obj/item/organ/brain))
			. += "<span class='deadsay'>[t_on] �� ��������� �� ������������ ������; ��� ��������� �����...</span>"
		else if(get_bodypart(BODY_ZONE_HEAD))
			. += "<span class='deadsay'>������, ��� � �[t_ego] ��� �����...</span>"

	var/list/missing = get_missing_limbs()
	for(var/t in missing)
		if(t==BODY_ZONE_HEAD)
			. += "<span class='deadsay'><B>[ru_ego(TRUE)] [parse_zone(t)] �����������!</B></span>"
			continue
		. += "<span class='warning'><B>[ru_ego(TRUE)] [parse_zone(t)] �����������!</B></span>"

	var/list/msg = list("<span class='warning'>")
	var/temp = getBruteLoss()
	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if (temp < 25)
				msg += "[t_on] ����� �������������� �����.\n"
			else if (temp < 50)
				msg += "[t_on] <b>������</b> �����[t_a]!\n"
			else
				msg += "<B>[t_on] ���������� �����[t_a]!</B>\n"

		temp = getFireLoss()
		if(temp)
			if (temp < 25)
				msg += "[t_on] ������� ��������[t_a].\n"
			else if (temp < 50)
				msg += "[t_on] ����� <b>���������</b> �����!\n"
			else
				msg += "<B>[t_on] ����� ����������� �����!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_on] �������������� ������������ �����������.\n"
			else if(temp < 50)
				msg += "[t_on] <b>�������</b> ������������ �����������!\n"
			else
				msg += "<b>[t_on] ����������� ������������ �����������!</b>\n"

	if(HAS_TRAIT(src, TRAIT_DUMB))
		msg += "[t_on] ����� ������ ��������� ����.\n"

	if(fire_stacks > 0)
		msg += "[t_on] � ���-�� �������.\n"
	if(fire_stacks < 0)
		msg += "[t_on] �������� �����.\n"

	if(pulledby && pulledby.grab_state)
		msg += "[t_on] ������������ �������� [pulledby].\n"

	msg += "</span>"

	. += msg.Join("")

	if(!appears_dead)
		if(stat == UNCONSCIOUS)
			. += "[t_on] �� ��������� �� ������������ ������.\n"
		else if(InCritical())
			. += "[t_on] ���� � ��������.\n"

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam

	var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
	if(mood)
		switch(mood.shown_mood)
			if(-INFINITY to MOOD_LEVEL_SAD4)
				. += "[t_on] �������� �����, ����� ������ �����������."
			if(MOOD_LEVEL_SAD4 to MOOD_LEVEL_SAD3)
				. += "[t_on] �������� ����������."
			if(MOOD_LEVEL_SAD3 to MOOD_LEVEL_SAD2)
				. += "[t_on] �������� ������� �� � ����."
			if(MOOD_LEVEL_HAPPY2 to MOOD_LEVEL_HAPPY3)
				. += "[t_on] �������� ������� �� ������."
			if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
				. += "[t_on] �������� ����� ������."
			if(MOOD_LEVEL_HAPPY4 to INFINITY)
				. += "[t_on] � �������."
	. += "*---------*</span>"
