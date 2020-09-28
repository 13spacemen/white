//Cloaks. No, not THAT kind of cloak.

/obj/item/clothing/neck/cloak
	name = "коричневый плащ"
	desc = "Это плащ, который можно носить на шее."
	icon = 'icons/obj/clothing/cloaks.dmi'
	icon_state = "qmcloak"
	inhand_icon_state = "qmcloak"
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESUITSTORAGE

/obj/item/clothing/neck/cloak/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is strangling [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return(OXYLOSS)

/obj/item/clothing/neck/cloak/hos
	name = "плащ главы службы безопасности"
	desc = "Носит Секуристан, управляя станцией железным кулаком."
	icon_state = "hoscloak"

/obj/item/clothing/neck/cloak/qm
	name = "плащ завхоза"
	desc = "Носит Каргония, снабжая станцию необходимыми инструментами для выживания."

/obj/item/clothing/neck/cloak/cmo
	name = "плащ главного врача"
	desc = "Носимые Медитопией, доблестные мужчины и женщины держат эпидемию в страхе."
	icon_state = "cmocloak"

/obj/item/clothing/neck/cloak/ce
	name = "плащ старшего инженера"
	desc = "Носит Энджитопия, обладатели неограниченной власти."
	icon_state = "cecloak"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/cloak/rd
	name = "плащ научного руководителя"
	desc = "Носят Сайенсия, тауматурги и исследователи вселенной."
	icon_state = "rdcloak"

/obj/item/clothing/neck/cloak/cap
	name = "плащ капитана"
	desc = "Носится командиром Космической Станции 13."
	icon_state = "capcloak"

/obj/item/clothing/neck/cloak/hop
	name = "плащ главы персонала"
	desc = "Носится начальником отдела кадров. Слабо пахнет бюрократией."
	icon_state = "hopcloak"

/obj/item/clothing/suit/hooded/cloak/goliath
	name = "плащ голиафа"
	icon_state = "goliath_cloak"
	desc = "Прочный практичный плащ из многочисленных кусков монстров, он востребован среди ссыльных и отшельников."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/pickaxe, /obj/item/spear, /obj/item/organ/regenerative_core/legion, /obj/item/kitchen/knife/combat/bone, /obj/item/kitchen/knife/combat/survival)
	armor = list(MELEE = 35, BULLET = 10, LASER = 25, ENERGY = 35, BOMB = 25, BIO = 0, RAD = 0, FIRE = 60, ACID = 60) //a fair alternative to bone armor, requiring alternative materials and gaining a suit slot
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/head/hooded/cloakhood/goliath
	name = "капюшон плаща голиафа"
	icon_state = "golhood"
	desc = "Защитный и скрывающий капюшон."
	armor = list(MELEE = 35, BULLET = 10, LASER = 25, ENERGY = 35, BOMB = 25, BIO = 0, RAD = 0, FIRE = 60, ACID = 60)
	clothing_flags = SNUG_FIT
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	transparent_protection = HIDEMASK

/obj/item/clothing/suit/hooded/cloak/drake
	name = "доспехи дракона"
	icon_state = "dragon"
	desc = "Костюм доспехов из остатков пепельного дракона."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/spear)
	armor = list(MELEE = 70, BULLET = 30, LASER = 50, ENERGY = 50, BOMB = 70, BIO = 60, RAD = 50, FIRE = 100, ACID = 100)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/drake
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	transparent_protection = HIDEGLOVES|HIDESUITSTORAGE|HIDEJUMPSUIT|HIDESHOES

/obj/item/clothing/head/hooded/cloakhood/drake
	name = "голова дракона"
	icon_state = "dragon"
	desc = "Череп дракона."
	armor = list(MELEE = 70, BULLET = 30, LASER = 50, ENERGY = 50, BOMB = 70, BIO = 60, RAD = 50, FIRE = 100, ACID = 100)
	clothing_flags = SNUG_FIT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/neck/cloak/skill_reward
	var/associated_skill_path = /datum/skill
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE

/obj/item/clothing/neck/cloak/skill_reward/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Я ощущаю сильную ауру окружающую этот плащ. Предполагаю, что им может владеть только кто-то по настоящему опытный.</span>"

/obj/item/clothing/neck/cloak/skill_reward/proc/check_wearable(mob/user)
	return user.mind?.get_skill_level(associated_skill_path) < SKILL_LEVEL_LEGENDARY

/obj/item/clothing/neck/cloak/skill_reward/proc/unworthy_unequip(mob/user)
	to_chat(user, "<span class = 'notice'>Я чую что я полностью и абсолютно не готов даже прикоснуться к \the [src].</span>")
	var/hand_index = user.get_held_index_of_item(src)
	if (hand_index)
		user.dropItemToGround(src, TRUE)
	return FALSE

/obj/item/clothing/neck/cloak/skill_reward/equipped(mob/user, slot)
	if (check_wearable(user))
		unworthy_unequip(user)
	return ..()

/obj/item/clothing/neck/cloak/skill_reward/attack_hand(mob/user)
	if (check_wearable(user))
		unworthy_unequip(user)
	return ..()

/obj/item/clothing/neck/cloak/skill_reward/gaming
	name = "плащ легендарного геймера"
	desc = "Его носят только самые скилловые професиональные геймеры станции. Этот легендарный плащ можно получить только достигнув истинного геймерского просветления. Этот статусный символ представляет удивительную мощь сосредоточенности, решимости и чистой, блять, силы воли. То, чего казуальные геймеры никогда не поймут."
	icon_state = "gamercloak"
	associated_skill_path = /datum/skill/gaming

/obj/item/clothing/neck/cloak/skill_reward/cleaning
	name = "плащ легендарного уборщика"
	desc = "Его носят только самые скилловые хранители чистоты. Этот легендарный плащ можно получить только достигнув истинного уборочного просветления. Этот статусный символ представляет существо, не только хорошо обученное борьбе с грязью, а готовое использовать целиком свой арсенал чистящих средств для того чтобы целиком стереть это жалкое грязевое пятно с лица станции."
	icon_state = "cleanercloak"
	associated_skill_path = /datum/skill/cleaning

/obj/item/clothing/neck/cloak/skill_reward/mining
	name = "плащ легендарного шахтера"
	desc = "Его носят только самые скилловые Шахтеры. Этот легендарный плащ можно получить только достигнув истинного минерального просветления. Этот статусный символ представляет существо, которое забыло про камни больше, чем большинств шахтеров когда-либо узнает. Существо, которое сдвинуло горы и заполнило долины."
	icon_state = "minercloak"
	associated_skill_path = /datum/skill/mining

/obj/item/clothing/neck/cloak/skill_reward/playing
	name = "плащ легендарного ветерана"
	desc = "Его носят только мудрейшие из сотрудников. Этот легендарный плащ можно получить только заключив трудовой договор с Нанотрансен на срок более <b>пяти тысяч часов</b>. Этот статусный символ представляет существо, которое лучше вас почти во всех измеримых областях, только и всего."
	icon_state = "playercloak"

/obj/item/clothing/neck/cloak/skill_reward/playing/check_wearable(mob/user)
	return user.client?.get_exp_living(TRUE) >= PLAYTIME_VETERAN
