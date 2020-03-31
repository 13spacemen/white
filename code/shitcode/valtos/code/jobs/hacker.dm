/datum/job/hacker
	title = "Hacker"
	flag = SCIENTIST
	department_head = list("Research Director")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "научному руководителю"
	selection_color = "#00eeff"
	exp_requirements = 30000
	exp_type = EXP_TYPE_CREW
	display_order = JOB_DISPLAY_ORDER_SCIENTIST

	outfit = /datum/outfit/job/hacker

	mind_traits = list(TRAIT_HACKER)

/datum/job/hacker/get_access()
	return get_all_accesses()

/datum/atom_hud/hacker
	hud_icons = list(HACKER_HUD)

/mob/living/Initialize()
	. = ..()
	var/datum/atom_hud/hacker/hhud = GLOB.huds[DATA_HUD_HACKER]
	hhud.add_to_hud(src)
	hud_list[HACKER_HUD].icon = image('code/shitcode/valtos/icons/dz-031.dmi', src)
	hud_list[HACKER_HUD].icon_state = "node"

/mob/living/simple_animal/hostile/Initialize()
	. = ..()
	hud_list[HACKER_HUD].add_overlay("node_enemy")

/obj/item/gun/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(HAS_TRAIT(H, TRAIT_HACKER))
			prepare_huds()
			var/datum/atom_hud/hacker/hhud = GLOB.huds[DATA_HUD_HACKER]
			hhud.add_to_hud(src)
			hud_list[HACKER_HUD].icon = image('code/shitcode/valtos/icons/dz-031.dmi', src)
			hud_list[HACKER_HUD].icon_state = "node_weapon"

/datum/job/hacker/after_spawn(mob/living/carbon/human/H, mob/M)
	ADD_TRAIT(H, TRAIT_HACKER, JOB_TRAIT)
	H.add_client_colour(/datum/client_colour/hacker)
	H.hud_list[HACKER_HUD].icon = null
	H.alpha = 75
	H.verbs += /mob/living/carbon/proc/immortality
	M.AddSpell(/obj/effect/proc_holder/spell/self/hacker_heal)
	M.AddSpell(/obj/effect/proc_holder/spell/targeted/remove_retard)
	SEND_SOUND(M, 'code/shitcode/valtos/sounds/hacker_hello.ogg', 100)
	spawn(50)
		H.hud_used.update_parallax_pref(H, TRUE)

/datum/client_colour/hacker
	colour = list(rgb(255,35,65), rgb(-65,200,45), rgb(-65,-35,255), rgb(0,0,0))
	priority = 6

/obj/item/clothing/glasses/hud/wzzzz/hacker_rig/equipped(mob/living/carbon/human/H, slot)
	. = ..()
	spawn(10)
		if(!HAS_TRAIT(H, TRAIT_HACKER))
			H.dropItemToGround(src, TRUE)
			H.Paralyze(50)
			H.electrocute_act(10, src)
			H.emote("scream")
			to_chat(H, "<span class='danger'>УЖАС! ЧТО ЭТО ТАКОЕ БЛЯТЬ?! СУКА!!!</span>")
			visible_message("<span class='warning'><b>[H]</b> в панике бросает [src] на пол!</span>")

/obj/item/clothing/suit/space/wzzzz/hacker_rig/equipped(mob/living/carbon/human/H, slot)
	. = ..()
	spawn(10)
		if(!HAS_TRAIT(H, TRAIT_HACKER))
			H.dropItemToGround(src, TRUE)
			H.Paralyze(50)
			H.electrocute_act(10, src)
			H.emote("scream")
			to_chat(H, "<span class='danger'>УЖАС! ЧТО ЭТО ТАКОЕ БЛЯТЬ?! СУКА!!!</span>")
			visible_message("<span class='warning'><b>[H]</b> в панике бросает [src] на пол!</span>")

/obj/item/clothing/head/helmet/space/chronos/hacker/equipped(mob/living/carbon/human/H, slot)
	. = ..()
	spawn(10)
		if(!HAS_TRAIT(H, TRAIT_HACKER))
			H.dropItemToGround(src, TRUE)
			H.Paralyze(50)
			H.electrocute_act(10, src)
			H.emote("scream")
			to_chat(H, "<span class='danger'>УЖАС! ЧТО ЭТО ТАКОЕ БЛЯТЬ?! СУКА!!!</span>")
			visible_message("<span class='warning'><b>[H]</b> в панике бросает [src] на пол!</span>")

/obj/item/clothing/head/helmet/space/chronos/hacker
	color = "#00ffff"
	name = "гипершлем"
	desc = "А ты заслуживаешь это?"
	flags_inv = 0
	mob_overlay_icon = null
	slowdown = -1
	strip_delay = 1300
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100,"energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

/obj/effect/proc_holder/spell/self/hacker_heal
	name = "Источник силы"
	desc = "Восполняет недостатки в теле."
	human_req = TRUE
	clothes_req = FALSE
	charge_max = 100
	cooldown_min = 50
	invocation = "Уёбки, сука!"
	invocation_type = "whisper"
	school = "restoration"
	sound = 'code/shitcode/valtos/sounds/hacker_heal.ogg'
	action_icon_state = "spacetime"

/obj/effect/proc_holder/spell/self/hacker_heal/cast(list/targets, mob/living/carbon/human/user)
	user.visible_message("<span class='warning'>Странный свет исходит от <b>[user]</b>!</span>", "<span class='notice'>Мне удалось немного исправить своё тело!</span>")
	user.adjustBruteLoss(-10)
	user.adjustFireLoss(-10)

/obj/effect/proc_holder/spell/targeted/remove_retard
	name = "Стереть"
	desc = "При помощи этого я могу уничтожать тех, кто портит систему."
	school = "destruction"
	charge_type = "recharge"
	charge_max	= 150
	charge_counter = 0
	clothes_req = FALSE
	stat_allowed = FALSE
	invocation = "Исчезни, пидор!"
	invocation_type = "shout"
	range = 7
	cooldown_min = 30
	selection_type = "range"
	action_icon_state = "spacetime"

/obj/effect/proc_holder/spell/targeted/remove_retard/cast(list/targets, mob/user = usr)
	if(!targets.len)
		to_chat(user, "<span class='warning'>Не нашел гниду!</span>")
		return

	var/mob/living/carbon/target = targets[1]

	if(!(target in oview(range)))
		to_chat(user, "<span class='warning'>Этот пидор слишком далеко!</span>")
		return

	to_chat(target, "<span class='danger'>Кто-то хочет мне навредить!</span>")

	user.visible_message("<span class='warning'><b>[user]</b> бормочет себе что-то под нос!</span>", \
						   "<span class='danger'>Сейчас я этого пидораса сотру нахуй!</span>")

	if(do_after(user, 50, target = target))
		user.whisper(md5("Цель: [target]"))
		if(do_after(user, 30, target = target))
			user.whisper(md5("Метод: удаление"))
			if(do_after(user, 30, target = target))
				user.say("Эй, [target], тебе сейчас будет пиздец!")
				if(do_after(user, 60, target = target))
					user.whisper(md5("Удаление..."))
					target.emote("scream")
					target.visible_message("<span class='danger'><b>[target]</b> исчезает!</span>", \
									"<span class='danger'>Мне пиздец!</span>")
					playsound(target, 'code/shitcode/valtos/sounds/mechanized/kr1.wav', 100)
					spawn(5)
						qdel(target.client)
						spawn(5)
							target.dust(TRUE,TRUE)
