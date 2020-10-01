/obj/effect/decal/cleanable/cum
	name = "сметанка"
	desc = "Выглядит вкусно."
	density = 0
	layer = 3
	icon = 'white/valtos/icons/exrp/smetanka.dmi'
	anchored = 1
	random_icon_states = list("cum1", "cum3", "cum4", "cum5", "cum6", "cum7", "cum8", "cum9", "cum10", "cum11", "cum12")
	reagents

/obj/effect/decal/cleanable/cum/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/nutriment/protein, 5)
	pixel_x = rand(-8, 8)
	pixel_y = rand(-8, 8)


/obj/effect/decal/cleanable/cum/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		playsound(get_turf(src), 'sound/items/drink.ogg', 50, TRUE) //slurp
		H.visible_message("<span class='alert'>[H] слизывает сметанку с пола.</span>")
		if(reagents)
			for(var/datum/reagent/R in reagents.reagent_list)
				if (istype(R, /datum/reagent/consumable))
					var/datum/reagent/consumable/nutri_check = R
					if(nutri_check.nutriment_factor >0)
						H.adjust_nutrition(nutri_check.nutriment_factor * nutri_check.volume)
						reagents.remove_reagent(nutri_check.type,nutri_check.volume)
		reagents.trans_to(H, reagents.total_volume, transfered_by = user)
		qdel(src)
