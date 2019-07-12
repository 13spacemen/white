/turf/open/floor/plating/conc
	name = "���������� �����"
	icon = 'code/shitcode/hule/magic/pomoyka/pomoyka.dmi'
	icon_plating = "concrete0"
	icon_state = "concrete0"

/turf/open/floor/plating/conc/Initialize()
	. = ..()
	if(prob(25))
		var/r = rand(1,2)
		icon_plating = "concrete[r]"
		icon_state = "concrete[r]"

/*
/obj/item/stack/tile/conc
	name = "���������� ����������� �������� ������"
	desc = "�����? ��� ��� ��������?"
	icon = 'code/shitcode/hule/magic/pomoyka/pomoyka.dmi'
	icon_state = "conc-tile"
	turf_type = /turf/open/floor/plating/conc
	resistance_flags = FLAMMABLE
*/

/obj/structure/tyre
	name = "�������� �� ������"
	icon = 'code/shitcode/hule/magic/pomoyka/pomoyka.dmi'
	icon_state = "shina0"
	desc = ""
	resistance_flags = FLAMMABLE
	max_integrity = 100
	anchored = TRUE

/obj/structure/tyre/pile
	name = "���� ��������"
	desc = "���� ��������, ������������� � ���� �����"
	icon_state = "shina4"
	max_integrity = 200
	density = TRUE

/obj/structure/tyre/pile/Initialize()
	. = ..()
	if(prob(30))
		icon_state = "shina[rand(1,3)]"

/obj/structure/tbin
	name = "�������"
	icon = 'code/shitcode/hule/magic/pomoyka/pomoyka.dmi'
	icon_state = "yashik_musor0"
	resistance_flags = FIRE_PROOF
	max_integrity = 400
	anchored = TRUE
	density = TRUE

/obj/structure/tbin/Initialize()
	. = ..()
	if(prob(50))
		icon_state = "yashik_musor1"

/obj/structure/tbin/full
	name = "���������� �������"
	desc = "������ ������������� �������"
	icon_state = "yashik_musor0_full"
	var/list/lootn = list(	/obj/item/shard,
							/obj/item/reagent_containers/syringe
						)
	var/list/lootold = list(/obj/item/reagent_containers/food/snacks/grown/tomato,
							/obj/item/reagent_containers/food/snacks/grown/eggplant,
							/obj/item/reagent_containers/food/snacks/grown/carrot,
							/obj/item/reagent_containers/food/snacks/grown/apple,
							/obj/item/reagent_containers/food/snacks/grown/potato
						)
	var/list/lootr = list(	/obj/item/seeds/reishi,
							/obj/item/reagent_containers/food/snacks/khachapuri,
							/obj/item/soap,
							/obj/item/switchblade
						)
	var/ageb = 50
	var/usesleft = 10
	var/time = 0
	var/time2use = 300

/obj/structure/tbin/full/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	if(prob(50))
		icon_state = "yashik_musor1_full"


/obj/structure/tbin/full/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/tbin/full/process()
	time++
	if(time >= time2use)
		time = 0
		usesleft++

/obj/structure/tbin/full/proc/spawnjunk(list/L, mob/M)
	var/obj/O = pick(L)
	var/obj/I = new O(get_turf(src),src)
	to_chat(M,"<span class='notice'>�� ����� [I.name]</span>")

/obj/structure/tbin/full/verb/use()
	set category = "IC"
	set name = "�������� � �������"
	set src in view(1)

	if(usesleft <= 0)
		to_chat(usr,"<span class='notice'>��� ������� �����</span>")
		return

	if(!ismonkey(usr)&&!ishuman(usr)|| usr.stat)
		to_chat(usr,"<span class='warning'>�� ��� ����� �� ������� ���� � ������� �� ���</span>")
		return

	if(prob(30))
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			if(H.age >= ageb && rand(30))
				spawnjunk(lootold, H)
			else
				spawnjunk(lootn, H)
		else
			spawnjunk(lootn, usr)

		if(prob(1))
			spawnjunk(lootr, usr)
		usesleft--
	else
		to_chat(usr,"<span class='notice'>�� ������ �� �����</span>")

/obj/effect/proc_holder/spell/targeted/pomoyka
	name = "������ ������ �������"
	desc = "���� ������� ��������� ���������� ������� �� ������� ���� ���� ������!!!!!"
	school = "College of �������� humor, Manayamirok state, USA"
	charge_max = 100
	clothes_req = FALSE
	invocation = "V GOLOVU"
	invocation_type = "shout"
	sound = 'code/shitcode/hule/SFX/anekdot_delimiter.ogg'
	action_icon_state = "shield"
	range = -1
	include_user = TRUE

/obj/effect/proc_holder/spell/targeted/pomoyka/cast(list/targets,mob/user = usr)
	new /obj/structure/pomoyka(get_turf(user),user)

	for(var/obj/effect/proc_holder/spell/aspell in user.mind.spell_list)
		if("������ ������ �������" == aspell.name)
			user.mind.spell_list.Remove(aspell)

/obj/structure/pomoyka
	name = "������ �������"
	desc = ""
	icon = 'code/shitcode/hule/magic/pomoyka/pomoyka.dmi'
	icon_state = "fawkes"
	anchored = TRUE
	opacity = 0
	density = TRUE
	max_integrity = 1000
	var/radius = 1
	var/timemul = 2
	var/time = 0
	var/bdmgmul = 10
	var/bdmgacc = 0
	var/bdmg = 7
	var/list/musor = list(	/obj/structure/tyre,
							/obj/structure/tyre/pile,
							/obj/structure/tbin/full
						)

/obj/structure/pomoyka/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	for(var/turf/open/floor/T in range(radius, src))
		T.ChangeTurf(/turf/open/floor/plating/conc)


/obj/structure/pomoyka/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/pomoyka/process()
	desc = "����� �������� �������� ����� ��� � ����� \n�����: [time] / [timemul ** radius] \n������: [radius] \n�������: [bdmgacc] / [radius * bdmgmul]"
	for(var/mob/living/carbon/human/H in range(radius, src))
		var/bhp = 200 - H.getBrainLoss()
		if(bhp > bdmg)
			H.adjustBrainLoss(bdmg)
			bdmgacc += bdmg
		/*else if(bhp > 0)
			H.adjustBrainLoss(bhp)
			bdmgacc += bhp*/

	if(time >= timemul ** radius)
		if(bdmgacc >= radius * bdmgmul)
			time = 0
			bdmgacc -= radius * bdmgmul
			radius++

			for(var/turf/open/floor/T in range(radius, src))
				if(!(T in range(radius - 1, src)))
					T.ChangeTurf(/turf/open/floor/plating/conc)
					if(prob(20))
						var/obj/M = safepick(musor)
						new M(T)

	else
		time++

/obj/structure/pomoyka/singularity_pull()
	return

/obj/item/book/granter/spell/pomoyka
	spell = /obj/effect/proc_holder/spell/targeted/pomoyka
	spellname = "pomoyka"
	icon_state ="bookfireball"
	desc = "������ ����� ����� ������ �� �����"
	remarks = list("����?", "����� ����� - ����� � ���...", "������������... ")
