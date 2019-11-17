/obj/projectile/bullet/rifle/a556
	damage = 50
	armour_penetration = 25
	
/obj/item/ammo_casing/wzzzz/a556
	desc = "A 5.56mm bullet casing."
	caliber = "a556"
	projectile_type = /obj/projectile/bullet/rifle/a556
	icon = 'code/shitcode/Wzzzz/icons/ammo.dmi'
	icon_state = "rifle_casing"
	item_state = "rifle_casing"
	
/obj/item/ammo_box/magazine/wzzzz/g43
	name = "magazine (5.56mm)"
	icon_state = "5.56"
	caliber = "a556"
	ammo_type = /obj/item/ammo_casing/wzzzz/a556
	icon = 'code/shitcode/Wzzzz/icons/ammo.dmi'
	max_ammo = 15
	multiple_sprites = 1
	
/obj/item/gun/ballistic/automatic/wzzzz/g43
	name = "G-43"
	desc = "Semi-automatic german rifle."
	icon_state = "g43"
	item_state = "g43"
	weapon_weight = WEAPON_HEAVY
	mag_type = /obj/item/ammo_box/magazine/wzzzz/g43
	fire_sound = 'code/shitcode/Wzzzz/gunshot3.ogg'
	icon = 'code/shitcode/Wzzzz/icons/Weea.dmi'
	lefthand_file = 'code/shitcode/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'code/shitcode/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
	mob_overlay_icon = 'code/shitcode/Wzzzz/icons/clothing/mob1/back.dmi'
	fire_delay = 10
	burst_size = 1
	actions_types = list()
	mag_display = TRUE
	can_suppress = FALSE
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
