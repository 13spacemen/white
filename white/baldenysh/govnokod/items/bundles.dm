/obj/item/storage/briefcase/surgery
	name = "кейс полевого хирурга"
	desc = "Алюминиевый кейс, содержащий все необходимое для проведения операций в полевых условиях."
	icon_state = "briefcase"
	icon = 'white/valtos/icons/items.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	force = 12
	throwforce = 12

/obj/item/storage/briefcase/surgery/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 14
	STR.max_combined_w_class = 30

/obj/item/storage/briefcase/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/razor(src)
	new /obj/item/blood_filter(src)
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/glass/bottle/epinephrine(src)
	new /obj/item/healthanalyzer(src)
