//telepadovo

/area/ruin/space/has_grav/telepadovo
	name = "Telepadovo"

/datum/map_template/ruin/space/telepadovo
	id = "telepadovo"
	suffix = "wruin1.dmm"
	name = "Telepadovo"
	description = "�������� � ��������� ����� ����� �������������, � ��������� ���� ����� ���������� ����������� ������������� ����� ��������."

//austation

/obj/effect/mob_spawn/human/austation
	name = "old cryogenics pod"
	desc = "��������� ������� �������. ���� �������������, �� ������ ��������� ������ �������."
	mob_name = "���������"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	flavour_text = "<span class='big bold'>��� ������� ���������� ���� ����� ���. ���� �� ������ ��� ��� ��������� � ������.</b>"
	uniform = /datum/outfit/job/assistant
	shoes = null
	assignedrole = "Autism Crew"

/obj/effect/mob_spawn/human/austation/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/area/ruin/space/has_grav/austation
	name = "Autism Station"

/datum/map_template/ruin/space/austation
	id = "austation"
	suffix = "wruin2.dmm"
	name = "Autism Station"
	description = "����������� ���������� ���������� ������� �������. ������� ��������� ������� ����� ������� � ������ ����������� ����������� �������� ��� ���������."