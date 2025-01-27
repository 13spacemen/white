/obj/item/computer_hardware/network_card
	name = "Сетевая карта"
	desc = "Базовая беспроводная сетевая карта для использования со стандартными частотами NTNet."
	power_usage = 50
	icon_state = "radio_mini"
	network_id = NETWORK_CARDS // Network we are on
	var/hardware_id = null // Identification ID. Technically MAC address of this device. Can't be changed by user.
	var/identification_string = "" // Identification string, technically nickname seen in the network. Can be set by user.
	var/long_range = 0
	var/ethernet = 0 // Hard-wired, therefore always on, ignores NTNet wireless checks.
	malfunction_probability = 1
	device_type = MC_NET


/obj/item/computer_hardware/network_card/diagnostics(mob/user)
	..()
	to_chat(user, "NIX Unique ID: [hardware_id]")
	to_chat(user, "NIX User Tag: [identification_string]")
	to_chat(user, "Поддерживаемые протоколы:")
	to_chat(user, "511.m SFS (Subspace) — Стандартный диапазон частот")
	if(long_range)
		to_chat(user, "511.n WFS/HB (Subspace) — Широкий диапазон частот / широкая полоса пропускания")
	if(ethernet)
		to_chat(user, "OpenEth (Physical Connection) — Физический порт сетевого подключения")


// Returns a string identifier of this network card
/obj/item/computer_hardware/network_card/proc/get_network_tag()
	return "[identification_string] (NID [hardware_id])"

// 0 - No signal, 1 - Low signal, 2 - High signal. 3 - Wired Connection
/obj/item/computer_hardware/network_card/proc/get_signal(specific_action = 0)
	if(!holder) // Hardware is not installed in anything. No signal. How did this even get called?
		return 0

	if(!check_functionality())
		return 0

	if(ethernet) // Computer is connected via wired connection.
		return 3

	if(!SSnetworks.station_network || !SSnetworks.station_network.check_function(specific_action)) // NTNet is down and we are not connected via wired connection. No signal.
		return 0

	if(holder)

		var/turf/T = get_turf(holder)
		if((T && istype(T)) && (is_station_level(T.z) || is_mining_level(T.z)))
			// Computer is on station. Low/High signal depending on what type of network card you have
			if(long_range)
				return 2
			else
				return 1

	if(long_range) // Computer is not on station, but it has upgraded network card. Low signal.
		return 1

	return 0 // Computer is not on station and does not have upgraded network card. No signal.


/obj/item/computer_hardware/network_card/advanced
	name = "Усовершенствованная сетевая карта"
	desc = "Усовершенствованная сетевая карта для использования со стандартными частотами NTNet. Её передатчик достаточно силен, чтобы подключиться даже за пределами станции."
	long_range = 1
	power_usage = 100 // Better range but higher power usage.
	icon_state = "radio"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/computer_hardware/network_card/wired
	name = "Проводная сетевая карта"
	desc = "Усовершенствованная сетевая карта для использования со стандартными частотами NTNet. Она также поддерживает проводное соединение. "
	ethernet = 1
	power_usage = 100 // Better range but higher power usage.
	icon_state = "net_wired"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/computer_hardware/network_card/integrated //Borg tablet version, only works while the borg has power and is not locked
	name = "Канал передачи данных киборга"

/obj/item/computer_hardware/network_card/integrated/get_signal(specific_action = 0)
	var/obj/item/modular_computer/tablet/integrated/modularInterface = holder

	if(!modularInterface || !istype(modularInterface))
		return FALSE //wrong type of tablet

	if(!modularInterface.borgo)
		return FALSE //No borg found

	var/mob/living/silicon/robot/robo = modularInterface.borgo
	if(istype(robo))
		if(robo.lockcharge)
			return FALSE //lockdown restricts borg networking

		if(!robo.cell || robo.cell.charge == 0)
			return FALSE //borg cell dying restricts borg networking

	return ..()
