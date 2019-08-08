/datum/quirk/semiviolent
	name = "������������"
	desc = "����� � ������� ���������� ��� ����������� ���� ���������. ���������, ��� �� �� ������ ������� ���� ����������."
	value = 1
	//mob_trait = TRAIT_PACIFISM
	gain_text = "<span class='danger'>�� ���������� ���� �����, ������� � �������!</span>"
	lose_text = "<span class='notice'>�� ����������, ��� �� ������ �������� ���� �����.</span>"
	medical_record_text = "������� �������� ���������� � �� ����� ��������� ���� ��������� ���� ����-����."
	var/ragemode

/datum/quirk/semiviolent/on_process()
	if(quirk_holder.health < 65)
		if(HAS_TRAIT_FROM(quirk_holder,TRAIT_PACIFISM, "semiviolent"))
			REMOVE_TRAIT(quirk_holder, TRAIT_PACIFISM, "semiviolent")
		if(!ragemode)
			quirk_holder.reagents.add_reagent(/datum/reagent/medicine/ephedrine,2)
			ragemode = TRUE
	else
		if(!HAS_TRAIT_FROM(quirk_holder,TRAIT_PACIFISM, "semiviolent"))
			ADD_TRAIT(quirk_holder, TRAIT_PACIFISM, "semiviolent")
		if(ragemode)
			quirk_holder.reagents.add_reagent(/datum/reagent/toxin/skewium,30)
			ragemode = FALSE