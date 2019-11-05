/obj/item/gun/ballistic/energy_smg
	name = "Low-power energy SMG"
	desc = "A prototype burst energy weapon. Uses special external batteries which cannot be recharged."
	icon = 'code/shitcode/RedFoxIV/guns/energy_smg/energy_smg.dmi'
	icon_state = "energy_smg"
	item_state = "energy_smg"
	custom_materials = list(/datum/material/titanium=5000,/datum/material/diamond=500)
	lefthand_file = 'code/shitcode/RedFoxIV/guns/guns_lefthand.dmi'
	righthand_file = 'code/shitcode/RedFoxIV/guns/guns_righthand.dmi'
	fire_sound = 'code/shitcode/RedFoxIV/guns/energy_smg/fire.ogg'
	fire_sound_volume = 100

	//�������������� ������
	bolt_type = BOLT_TYPE_OPEN
	mag_type = /obj/item/ammo_box/magazine/energy_smg
	mag_display = TRUE
	burst_size = 10
	fire_delay = 0.7
	recoil = 0.12



//����������� ���� ��� ���������, ��������� �� ������ ���� �� ����� ����� ������ ��� � ���� ��� ������� � ���������� ����� ����� ��������, ������� ��� �� �����

/obj/item/gun/ballistic/energy_smg/examine(mob/user)
	. = list("[ru_get_examine_string(user, TRUE)].")
	. += desc
	. += "��� [weightclass2text(w_class)] �������."
	if(pin)
		. += "������ ���������� ��� ���� [pin.name]."
	else
		. += "������ ����������� <b>���</b>, ������� ��� �� ����� ��������."

	if(!magazine)
		. += "����������� �����������."
		return

	if(get_ammo())
		. += "������ ������� ��� �� [get_ammo()] ���������"
	else
		. += "����������� ��������."

	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .) //�� ��� ��� ���, �� ������� �������.

//��������� �� ballistic.dm, ������������ ��� ��� �����. (������ �� �������� �� ���, � ���������)
/obj/item/gun/ballistic/energy_smg/process_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	if(!semi_auto && from_firing)
		return
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(istype(AC)) //there's a chambered round
		if(casing_ejector || !from_firing)
			AC.Destroy()
			chambered = null
		else if(empty_chamber)
			chambered = null
	if (chamber_next_round && (magazine?.max_ammo > 1))
		chamber_round()

//��������� �� ballistics.dm, ������������ ��� ��� �����. (������� ������ �������������, ����������� � ���)
/obj/item/gun/ballistic/energy_smg/rack(mob/user = null)
	if(!bolt_locked)
		return
	if (user)
		return //�� ��� ������������ ������ ���� ������
	bolt_locked = FALSE
	process_chamber(!chambered, FALSE)
	update_icon()


/obj/item/gun/ballistic/energy_smg/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message = TRUE)
	..()
	rack()


/obj/item/gun/ballistic/eject_magazine(mob/user, display_message = TRUE, obj/item/ammo_box/magazine/tac_load = null)
	..()
	bolt_locked = TRUE



//��������� ��� �� ���, �� � ����� ��� ��. ��� ������ � ������
/obj/item/gun/ballistic/energy_smg/mindshield
	pin = /obj/item/firing_pin/implant/mindshield

//��� ���������
/obj/item/gun/ballistic/energy_smg/nopin
	pin = none
	spawnwithmagazine = FALSE

//--�������--
/obj/item/ammo_box/magazine/energy_smg
	name = "Low-power pulse battery"
	desc = "An external battery designed for a prototype weapon. Can't be recharged in standard weapon charging stations or battery  chargers."
	icon= 'code/shitcode/RedFoxIV/guns/energy_smg/energy_smg.dmi'
	icon_state = "energy_smg_ammobox"
	ammo_type = /obj/item/ammo_casing/energy_smg
	max_ammo = 50
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/attack_self(mob/user)
	return //�� ��� ����������� ������ �� ������������


//--��������--
/obj/item/ammo_box/magazine/energy_smg/debug
	max_ammo = 1488


//--������--
/obj/item/ammo_casing/energy_smg
	desc = "������� �����"
	caliber = "energy" //�� ������ ������
	projectile_type = /obj/projectile/bullet/energy_smg_bullet



/obj/projectile/bullet/energy_smg_bullet
	name = "energy pellet"
	damage = 3.2
	stamina = 1
	icon = 'code/shitcode/RedFoxIV/guns/energy_smg/energy_smg.dmi'
	icon_state = "energy_smg_proj"