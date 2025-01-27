/datum/round_event_control/wizard/magicarp //these fish is loaded
	name = "Magicarp"
	weight = 1
	typepath = /datum/round_event/wizard/magicarp
	max_occurrences = 1
	earliest_start = 0 MINUTES

/datum/round_event/wizard/magicarp
	announceWhen	= 3
	startWhen = 50

/datum/round_event/wizard/magicarp/setup()
	startWhen = rand(40, 60)

/datum/round_event/wizard/magicarp/announce(fake)
	priority_announce("Unknown magical entities have been detected near [station_name()], please stand-by.", "Lifesign Alert")

/datum/round_event/wizard/magicarp/start()
	for(var/obj/effect/landmark/carpspawn/C in GLOB.landmarks_list)
		if(prob(5))
			new /mob/living/simple_animal/hostile/carp/ranged/chaos(C.loc)
		else
			new /mob/living/simple_animal/hostile/carp/ranged(C.loc)

/mob/living/simple_animal/hostile/carp/ranged
	name = "magicarp"
	desc = "50% magic, 50% carp, 100% horrible."
	icon_state = "magicarp"
	icon_living = "magicarp"
	icon_dead = "magicarp_dead"
	icon_gib = "magicarp_gib"
	ranged = 1
	retreat_distance = 2
	minimum_distance = 0 //Between shots they can and will close in to nash
	projectiletype = /obj/projectile/magic
	projectilesound = 'sound/weapons/emitter.ogg'
	maxHealth = 50
	health = 50
	gold_core_spawnable = HOSTILE_SPAWN
	random_color = FALSE
	food_type = list()
	tame_chance = 0
	bonus_tame_chance = 0
	var/allowed_projectile_types = list(/obj/projectile/magic/change, /obj/projectile/magic/animate, /obj/projectile/magic/resurrection,
	/obj/projectile/magic/death, /obj/projectile/magic/teleport, /obj/projectile/magic/door, /obj/projectile/magic/aoe/fireball,
	/obj/projectile/magic/spellblade, /obj/projectile/magic/arcane_barrage)
	discovery_points = 3000

/mob/living/simple_animal/hostile/carp/ranged/Initialize(mapload)
	projectiletype = pick(allowed_projectile_types)
	. = ..()

/mob/living/simple_animal/hostile/carp/ranged/chaos
	name = "chaos magicarp"
	desc = "50% carp, 100% magic, 150% horrible."
	color = "#00FFFF"
	maxHealth = 75
	health = 75
	gold_core_spawnable = HOSTILE_SPAWN
	discovery_points = 5000

/mob/living/simple_animal/hostile/carp/ranged/chaos/Shoot()
	projectiletype = pick(allowed_projectile_types)
	..()

/mob/living/simple_animal/hostile/carp/ranged/xenobiology // these are for the xenobio gold slime pool
	gold_core_spawnable = HOSTILE_SPAWN
	allowed_projectile_types = list(/obj/projectile/magic/animate, /obj/projectile/magic/teleport,
	/obj/projectile/magic/door, /obj/projectile/magic/aoe/fireball, /obj/projectile/magic/spellblade, /obj/projectile/magic/arcane_barrage) //thanks Lett1

/mob/living/simple_animal/hostile/carp/ranged/chaos/xenobiology
	gold_core_spawnable = HOSTILE_SPAWN
	allowed_projectile_types = list(/obj/projectile/magic/animate, /obj/projectile/magic/teleport,
	/obj/projectile/magic/door, /obj/projectile/magic/aoe/fireball, /obj/projectile/magic/spellblade, /obj/projectile/magic/arcane_barrage)
