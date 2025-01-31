//Random seeds; stats, traits, and plant type are randomized for each seed.

/obj/item/seeds/random
	name = "Пачка странных семян"
	desc = "Такие же странные, как и их название. Стрёмно."
	icon_state = "seed-x"
	species = "?????"
	plantname = "strange plant"
	product = /obj/item/food/grown/random
	icon_grow = "xpod-grow"
	icon_dead = "xpod-dead"
	icon_harvest = "xpod-harvest"
	growthstages = 4
	custom_premium_price = PAYCHECK_EASY * 2

/obj/item/seeds/random/Initialize(mapload)
	. = ..()
	randomize_stats()
	if(prob(60))
		add_random_reagents(1, 3)
	if(prob(50))
		add_random_traits(1, 2)
	add_random_plant_type(35)

/obj/item/food/grown/random
	seed = /obj/item/seeds/random
	name = "Странный плод"
	desc = "Что это такое?"
	icon_state = "crunchy"
	bite_consumption_mod = 2

/obj/item/food/grown/random/Initialize(mapload)
	. = ..()
	wine_power = rand(10,150)
	if(prob(1))
		wine_power = 200
