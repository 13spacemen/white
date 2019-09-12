/obj/machinery/reagent_sheet
	name = "Reagent Refinery"
	desc = "Smelts and refines solid reagents into ingots- useable by the forge."
	icon_state = "furnace"
	icon = 'icons/obj/machines/mining_machines.dmi'
	density = TRUE
	anchored = TRUE
	use_power = IDLE_POWER_USE
	light_power = 0.5
	light_range = 2
	light_color = LIGHT_COLOR_FLARE
	var/working = FALSE
	var/datum/reagent/reagent_inside = null
	var/work_time = 300
	var/end_volume = 100
	circuit = /obj/item/circuitboard/machine/reagent_sheet

/obj/machinery/reagent_sheet/Initialize()
	create_reagents(100)
	. = ..()

/obj/machinery/reagent_sheet/RefreshParts()
	for(var/obj/item/stock_parts/micro_laser/ML in component_parts)
		work_time = (initial(work_time)/ML.rating)
	for(var/obj/item/stock_parts/matter_bin/MB in component_parts)
		end_volume = initial(end_volume) * MB.rating

/obj/machinery/reagent_sheet/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += "<span class='notice'>������� ����������: �� ������ <b>[end_volume/20]</b> ������� ����� <b>[work_time*0.1]</b> ������ ������.</span>"

/obj/machinery/reagent_sheet/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/reagent_containers/glass/beaker) && !panel_open)
		if(stat & BROKEN)
			to_chat(user, "<span class='warning'>[src.name] ������!</span>")
			return
		if(working)
			to_chat(user, "<span class='warning'>[src.name] ��� ��������!</span>")
			return
		else
			var/obj/item/reagent_containers/glass/beaker/RB = I
			if(LAZYLEN(RB.reagents.reagent_list) == 1)
				for(var/RR in RB.reagents.reagent_list)
					if(RB.reagents.total_volume && reagents.total_volume < reagents.maximum_volume)	
						RB.reagents.trans_to(src, RB.reagents.total_volume)
						reagent_inside = RR
						to_chat(user, "�� ������� [end_volume] ������ <b>[RR]</b> � ���������!")
			else
				to_chat(user, "<span class='warning'>[src.name] ���� ����� �������� �������. ����������� �������� ������ ������ ����!</span>")
				return
	else
		if(!working && default_deconstruction_screwdriver(user, icon_state, icon_state, I))
			return
		if(default_deconstruction_crowbar(I))
			return
		return ..()

/obj/machinery/reagent_sheet/attack_hand(mob/living/user)
	if (!working)
		working = TRUE
		use_power = reagents.total_volume
		addtimer(CALLBACK(src, /obj/machinery/reagent_sheet/proc/create_sheets, reagents.total_volume), work_time)
		visible_message("<span class='notice'>[src.name] ������������!</span>")
	else
		to_chat(user, "<span class='warning'>[src.name] �� ��� ��������!</span>")

/obj/machinery/reagent_sheet/proc/create_sheets(amount)
	var/sheet_amount = max(round(amount / MINERAL_MATERIAL_AMOUNT), 1)
	var/obj/item/stack/sheet/mineral/reagent/RS = new(get_turf(src))
	visible_message("<span class='notice'>[src.name] ����������� ������.</span>")
	playsound(src, 'sound/machines/ping.ogg', 50, 0)
	RS.amount = sheet_amount
	for(var/path in subtypesof(/datum/reagent))
		var/datum/reagent/RR = new path
		if(RR.type == reagent_inside.type)
			RS.reagent_type = RR
			RS.name = "[RR.name] ingots"
			RS.singular_name = "[RR.name] ingot"
			RS.add_atom_colour(RR.color, FIXED_COLOUR_PRIORITY)
			break
		else
			qdel(RR)
	reagents = null
	reagent_inside = null
	working = FALSE
	return

/obj/item/circuitboard/machine/reagent_sheet
	name = "Reagent Refinery (Machine Board)"
	build_path = /obj/machinery/reagent_sheet
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 3)