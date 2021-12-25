/obj/structure/blob/special/core
	name = "ядро массы"
	icon = 'icons/mob/blob_64.dmi'
	icon_state = "core"
	desc = "Огромная, пульсирующая масса."
	max_integrity = BLOB_CORE_MAX_HP
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 75, ACID = 90)
	explosion_block = 6
	point_return = -1
	health_regen = 0 //we regen in Life() instead of when pulsed
	resistance_flags = LAVA_PROOF
	strong_reinforce_range = BLOB_CORE_STRONG_REINFORCE_RANGE
	reflector_reinforce_range = BLOB_CORE_REFLECTOR_REINFORCE_RANGE
	claim_range = BLOB_CORE_CLAIM_RANGE
	pulse_range = BLOB_CORE_PULSE_RANGE
	expand_range = BLOB_CORE_EXPAND_RANGE
	max_spores = BLOB_CORE_MAX_SPORES
	ignore_syncmesh_share = TRUE

/obj/structure/blob/special/core/Initialize(mapload, client/new_overmind = null, placed = 0)
	GLOB.blob_cores += src
	START_PROCESSING(SSobj, src)
	SSpoints_of_interest.make_point_of_interest(src)
	update_icon() //so it atleast appears
	if(!placed && !overmind)
		return INITIALIZE_HINT_QDEL
	if(overmind)
		overmind.blobstrain.on_gain()
		update_icon()
	. = ..()

/obj/structure/blob/special/core/scannerreport()
	return "Собственно, ядро. Главный руководящий центр всей этой штуки."

/obj/structure/blob/special/core/update_icon()
	cut_overlays()
	color = null
	var/mutable_appearance/blob_overlay = mutable_appearance(icon, "corepulse")
	if(overmind)
		blob_overlay.color = overmind.blobstrain.color
	color = overmind.blobstrain.color
	for(var/obj/structure/blob/B in orange(src,1))
		overlays += image(icon, "coreconnect", dir = get_dir(src,B))
	add_overlay(blob_overlay)

	underlays.len = 0
	underlays += image(icon,"roots")

	update_health_overlay()

/obj/structure/blob/special/core/Destroy()
	GLOB.blob_cores -= src
	if(overmind)
		overmind.blob_core = null
	overmind = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/blob/special/core/ex_act(severity, target)
	var/damage = 10 * (severity + 1) //remember, the core takes half brute damage, so this is 20/15/10 damage based on severity
	take_damage(damage, BRUTE, BOMB, 0)

/obj/structure/blob/special/core/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir, overmind_reagent_trigger = 1)
	. = ..()
	if(obj_integrity > 0)
		if(overmind) //we should have an overmind, but...
			overmind.update_health_hud()

/obj/structure/blob/special/core/process(delta_time)
	if(QDELETED(src))
		return
	if(!overmind)
		qdel(src)
	if(overmind)
		overmind.blobstrain.core_process()
		overmind.update_health_hud()
	pulse_area(overmind, claim_range, pulse_range, expand_range)
	reinforce_area(delta_time)
	produce_spores()
	..()

/obj/structure/blob/special/core/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/stationloving, FALSE, TRUE)

/obj/structure/blob/special/core/onTransitZ(old_z, new_z)
	if(overmind && is_station_level(new_z))
		overmind.forceMove(get_turf(src))
	return ..()
