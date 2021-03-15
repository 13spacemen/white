/datum/job/engineer/mechanic
	title = "Механик"
	total_positions = 1
	spawn_positions = 1
	exp_requirements = 0
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/mechanic

	access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE, ACCESS_AUX_BASE,
		ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_ATMOSPHERICS, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM, ACCESS_RESEARCH, ACCESS_ATMOSPHERICS)
	minimal_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE, ACCESS_AUX_BASE,
		ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM, ACCESS_RESEARCH, ACCESS_ATMOSPHERICS)

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_ENG

	metalocked = TRUE

/area/engine/manufactory
	name = "Фабрика"
	icon_state = "engine"

/datum/outfit/job/mechanic
	name = "Механик"
	jobtype = /datum/job/engineer/mechanic

	belt = /obj/item/storage/belt/utility/full/engi
	l_pocket = /obj/item/pda/engineering
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/rank/engineering/engineer/wzzzz/mechanic
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/welding/open
	r_pocket = /obj/item/t_scanner
	l_hand = /obj/item/storage/part_replacer/cargo

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced = 1)

	skillchips = list(/obj/item/skillchip/job/engineer)

/obj/machinery/copytech
	name = "копирующий станок"
	desc = "Создаёт что угодно в неограниченных объёмах. Потребляет много энергии."
	icon = 'white/valtos/icons/something.dmi'
	circuit = /obj/item/circuitboard/machine/copytech
	icon_state = "apparatus"
	density = TRUE
	layer = MOB_LAYER
	var/scanned_type = null
	var/tier_rate = 1
	var/obj/machinery/copytech_platform/cp = null
	var/current_design = null
	var/working = FALSE
	var/atom/movable/active_item = null
	var/crystals = 0
	var/max_crystals = 4
	var/obj/structure/cable/attached_cable
	var/siphoned_power = 0
	var/siphon_max = 1e7

/obj/machinery/copytech/process()
	if(siphoned_power >= siphon_max)
		return
	update_cable()
	if(attached_cable)
		attempt_siphon()

/obj/machinery/copytech/proc/update_cable()
	var/turf/T = get_turf(src)
	attached_cable = locate(/obj/structure/cable) in T

/obj/machinery/copytech/proc/attempt_siphon()
	var/surpluspower = clamp(attached_cable.surplus(), 0, (siphon_max - siphoned_power))
	if(surpluspower)
		attached_cable.add_load(surpluspower)
		siphoned_power += surpluspower

/obj/machinery/copytech/examine(mob/user)
	. = ..()
	. += "<hr><span class='info'>Примерное время создания объекта: [time2text(get_replication_speed(tier_rate), "mm:ss")].</span>\n"
	. += "<span class='info'>Внутри запасено: <b>[crystals]/[max_crystals] блюспейс-кристаллов</b>.</span>\n"
	. += "<span class='info'>Накоплено энергии: <b>[num2loadingbar((siphon_max-siphoned_power)/siphon_max)] [DisplayPower(siphoned_power)]/[DisplayPower(siphon_max)]</b>.</span>"
	. += "<hr><span class='notice'>Похоже, ему требуется подключение к энергосети через кабель.</span>"

/obj/machinery/copytech/Initialize()
	. = ..()
	check_platform()

/obj/machinery/copytech/update_icon()
	. = ..()
	if(working)
		icon_state = "apparatus_on"
	else
		icon_state = "apparatus"

/obj/machinery/copytech/attacked_by(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/stack/ore/bluespace_crystal) || istype(I, /obj/item/stack/sheet/bluespace_crystal))
		if(crystals >= max_crystals)
			to_chat(user, "<span class='warning'>Перебор!</span>")
			return
		var/obj/item/stack/BC = I
		if(!BC.amount)
			to_chat(user, "<span class='warning'>БЛЯТЬ!</span>")
			return
		crystals++
		user.visible_message("[user] вставляет [I.name] в [src.name].", "<span class='notice'>Вставляю [I.name] в [src.name].</span>")
		BC.use(1)
		return
	else
		return ..()

/obj/machinery/copytech/attack_hand(mob/living/user)
	. = ..()
	if(working)
		say("Работа в процессе!")
		return
	if(siphoned_power < siphon_max)
		say("Недостаточно энергии.")
		return
	if(!cp)
		say("Не обнаружена дезинтегрирующая платформа. Попытка синхронизации...")
		check_platform()
		return
	if(!current_design)
		say("Не обнаружено дизайна. Разберите что-то сперва на дезинтегрирующей платформе!")
		return
	if(!crystals)
		say("Недостаточно блюспейс-кристаллов для начала работы!")
		return
	if(create_thing())
		say("Приступаю к процессу создания объекта...")
		working = TRUE
		update_icon()

/obj/machinery/copytech/proc/create_thing()

	var/atom/A = drop_location()

	if(ispath(current_design, /obj))
		var/obj/O = new current_design(A)
		O.set_anchored(TRUE)
		O.layer = ABOVE_MOB_LAYER
		O.alpha = 0
		var/mutable_appearance/result = mutable_appearance(O.icon, O.icon_state)
		var/mutable_appearance/scanline = mutable_appearance('icons/effects/effects.dmi',"transform_effect")
		O.transformation_animation(result, time = get_replication_speed(tier_rate), transform_overlay = scanline, reset_after=TRUE)
		active_item = O
		crystals--
		siphoned_power = 0
		spawn(get_replication_speed(tier_rate))
			O?.set_anchored(FALSE)
			O?.layer = initial(O?.layer)
			O?.alpha = initial(O?.alpha)
			say("Завершение работы...")
			working = FALSE
			update_icon()
		return TRUE
	else if (ispath(current_design, /mob/living))
		if(tier_rate < 8)
			say("Слишком слабая мощность лазера.")
			return FALSE
		var/mob/living/M = new current_design(A)
		M.SetParalyzed(get_replication_speed(tier_rate) * 2)
		M.emote("scream")
		M.layer = ABOVE_MOB_LAYER
		var/mutable_appearance/result = mutable_appearance(M.icon, M.icon_state)
		var/mutable_appearance/scanline = mutable_appearance('icons/effects/effects.dmi',"transform_effect")
		M.transformation_animation(result, time = get_replication_speed(tier_rate), transform_overlay = scanline, reset_after=TRUE)
		active_item = M
		crystals--
		siphoned_power = 0
		spawn(get_replication_speed(tier_rate))
			M?.SetParalyzed(FALSE)
			M?.layer = initial(M?.layer)
			say("Завершение работы...")
			working = FALSE
			update_icon()
		return TRUE
	else
		say("Неправильный дизайн!")
		return FALSE

/obj/machinery/copytech/RefreshParts()
	var/T = 0
	for(var/obj/item/stock_parts/micro_laser/M in component_parts)
		T += M.rating
	tier_rate = T

/proc/get_replication_speed(tier)
	return (60 SECONDS) / tier

/obj/machinery/copytech/proc/check_platform()
	if(!cp)
		for(var/obj/machinery/copytech_platform/M in range(3, src))
			cp = M
			return TRUE
	return FALSE

/obj/machinery/copytech_platform
	name = "дезинтегрирующая платформа"
	desc = "Уничтожает всё, что на ней есть, если активировать. Потребляет много энергии."
	icon = 'white/valtos/icons/something.dmi'
	circuit = /obj/item/circuitboard/machine/copytech_platform
	icon_state = "platform"
	density = 0
	layer = MOB_LAYER
	var/tier_rate = 1
	var/obj/machinery/copytech/ct = null
	var/working = FALSE
	var/atom/movable/active_item = null
	var/list/blacklisted_items = list(/obj/item/stack/telecrystal,
			/obj/item/stack/telecrystal/five,
			/obj/item/stack/telecrystal/twenty)
	var/obj/structure/cable/attached_cable
	var/siphoned_power = 0
	var/siphon_max = 1e7

/obj/machinery/copytech_platform/process()
	if(siphoned_power >= siphon_max)
		return
	update_cable()
	if(attached_cable)
		attempt_siphon()

/obj/machinery/copytech_platform/proc/update_cable()
	var/turf/T = get_turf(src)
	attached_cable = locate(/obj/structure/cable) in T

/obj/machinery/copytech_platform/proc/attempt_siphon()
	var/surpluspower = clamp(attached_cable.surplus(), 0, (siphon_max - siphoned_power))
	if(surpluspower)
		attached_cable.add_load(surpluspower)
		siphoned_power += surpluspower

/obj/machinery/copytech_platform/RefreshParts()
	var/T = 0
	for(var/obj/item/stock_parts/micro_laser/M in component_parts)
		T += M.rating
	tier_rate = T

/obj/machinery/copytech_platform/Crossed(H as mob|obj)
	..()
	if(!working)
		return
	if(!H)
		return
	if(isobserver(H))
		return
	if(!ismob(H))
		return
	if(isliving(H))
		var/mob/living/L = H
		L.adjustFireLoss(10)
		L.adjust_fire_stacks(5)
		L.IgniteMob()
		L.visible_message("<span class='danger'><b>[L]</b> прожаривается!</span>")
		playsound(L, 'sound/machines/shower/shower_mid1.ogg', 90, TRUE)

/obj/machinery/copytech_platform/examine(mob/user)
	. = ..()
	. += "<hr><span class='info'>Примерное время для уничтожения объекта: [time2text(get_replication_speed(tier_rate), "mm:ss")].</span>\n"
	. += "<span class='info'>Накоплено энергии: <b>[num2loadingbar((siphon_max-siphoned_power)/siphon_max)] [DisplayPower(siphoned_power)]/[DisplayPower(siphon_max)]</b>.</span>"
	. += "<hr><span class='notice'>Похоже, ему требуется подключение к энергосети через кабель.</span>"

/obj/machinery/copytech_platform/Initialize()
	. = ..()
	check_copytech()

/obj/machinery/copytech_platform/update_icon()
	. = ..()
	if(working)
		icon_state = "platform_on"
	else
		icon_state = "platform"

/obj/machinery/copytech_platform/attack_hand(mob/living/user)
	. = ..()
	if(working)
		say("Работа в процессе!")
		return
	if(siphoned_power < siphon_max)
		say("Недостаточно энергии.")
		return
	if(!ct)
		say("Не обнаружен копирующий станок. Попытка синхронизации...")
		check_copytech()
		return
	if(destroy_thing())
		say("Приступаю к процессу дезинтеграции объекта...")
		working = TRUE
		update_icon()

/obj/machinery/copytech_platform/proc/check_copytech()
	if(!ct)
		for(var/obj/machinery/copytech/M in range(3, src))
			ct = M
			return TRUE
	return FALSE

/obj/machinery/copytech_platform/proc/destroy_thing()
	if(!ct)
		return FALSE
	var/turf/T = get_turf(src)
	var/atom/movable/what_we_destroying = null
	if(T?.contents)
		for(var/thing in T.contents)
			if(istype(thing, /obj))
				var/obj/O = thing
				if(O.anchored || (O.resistance_flags & INDESTRUCTIBLE) || O == src)
					continue
				what_we_destroying = thing
			if(istype(thing, /mob/living) && tier_rate >= 8)
				what_we_destroying = thing
	if(what_we_destroying)
		what_we_destroying.set_anchored(TRUE)
		if(isliving(what_we_destroying))
			var/mob/living/M = what_we_destroying
			M.SetParalyzed(get_replication_speed(tier_rate) * 2)
			M.emote("scream")
			M.layer = ABOVE_MOB_LAYER
		what_we_destroying.layer = ABOVE_MOB_LAYER
		var/mutable_appearance/result = mutable_appearance('icons/effects/effects.dmi',"nothing")
		var/mutable_appearance/scanline = mutable_appearance('icons/effects/effects.dmi',"transform_effect")
		what_we_destroying.transformation_animation(result, time = get_replication_speed(tier_rate), transform_overlay = scanline, reset_after=TRUE)
		active_item = what_we_destroying
		siphoned_power = 0
		spawn(get_replication_speed(tier_rate))
			if(!src)
				return
			if(get_turf(what_we_destroying) != get_turf(src))
				say("ОШИБКА!!!")
				working = FALSE
				update_icon()
				return
			if(what_we_destroying in blacklisted_items)
				ct?.current_design = /obj/item/food/poo
			else
				ct?.current_design = what_we_destroying.type
			say("Завершение работы...")
			qdel(what_we_destroying)
			working = FALSE
			update_icon()
		return TRUE
	else
		return FALSE

/obj/item/circuitboard/machine/copytech
	name = "Копирующий станок (Оборудование)"
	icon_state = "engineering"
	build_path = /obj/machinery/copytech
	req_components = list(/obj/item/stock_parts/micro_laser = 1)

/obj/item/circuitboard/machine/copytech_platform
	name = "Дезинтегрирующая платформа (Оборудование)"
	icon_state = "engineering"
	build_path = /obj/machinery/copytech_platform
	req_components = list(/obj/item/stock_parts/micro_laser = 1)
