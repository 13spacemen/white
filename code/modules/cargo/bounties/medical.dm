/datum/bounty/item/medical/heart
	name = "Сердце"
	description = "Командир Джонсон находится в критическом состоянии после очередного сердечного приступа. Врачи говорят, что ему нужно новое сердце быстро. Отправьте один, быстро!"
	reward = 3000
	wanted_types = list(/obj/item/organ/heart, /obj/item/organ/heart/cybernetic/tier2, /obj/item/organ/heart/cybernetic/tier3)
	exclude_types = list(/obj/item/organ/heart/cybernetic)//Excluding tier 1s, no cheesing.

/datum/bounty/item/medical/lung
	name = "Лёгкие"
	description = "Недавний взрыв на ЦК оставил множество сотрудников с проколотыми легкими. Отправка запасных лёгких будет вознаграждена."
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/organ/lungs, /obj/item/organ/lungs/cybernetic/tier2, /obj/item/organ/lungs/cybernetic/tier3)
	exclude_types = list(/obj/item/organ/lungs/cybernetic)//As above, for all printable organs.

/datum/bounty/item/medical/appendix
	name = "Аппендицит"
	description = "Шеф-повар Гибб Центрального командования хочет приготовить еду, используя особый деликатес: аппендицит. Если вы отправите один, он вам заплатит."
	reward = 5000 //there are no synthetic appendixes
	wanted_types = list(/obj/item/organ/appendix)

/datum/bounty/item/medical/ears
	name = "Уши"
	description = "Несколько сотрудников на Станции 12 остались глухими из-за несанкционированной клоунады. Отправь им новые уши."
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/organ/ears, /obj/item/organ/ears/cybernetic/upgraded)
	exclude_types = list(/obj/item/organ/ears/cybernetic)

/datum/bounty/item/medical/liver
	name = "Печень"
	description = "Несколько высокопоставленных дипломатов ЦК были госпитализированы с печеночной недостаточностью после недавней встречи с послами стран Третьего Советского Союза. Помоги нам, ладно?"
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/organ/liver, /obj/item/organ/liver/cybernetic/tier2, /obj/item/organ/liver/cybernetic/tier3)
	exclude_types = list(/obj/item/organ/liver/cybernetic)

/datum/bounty/item/medical/eye
	name = "Глаза"
	description = "Директор по исследованиям станции 5 Виллем запрашивает несколько пар глаз. Не задавайте вопросы, просто отправляйте их."
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/organ/eyes)
	exclude_types = list(/obj/item/organ/eyes/robotic)

/datum/bounty/item/medical/tongue
	name = "Язык"
	description = "Недавнее нападение мимов экстремистов оставило персонал на Станции 23 безмолвным. Отправьте несколько запасных языков."
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/organ/tongue)

/datum/bounty/item/medical/lizard_tail
	name = "Хвост ящерицы"
	description = "Федерация Волшебников закончила поставку для НТ хвостов ящериц. Пока ЦК ведёт переговоры с волшебниками, может ли станция пощадить свой хвост?"
	reward = 3000
	wanted_types = list(/obj/item/organ/tail/lizard)

/datum/bounty/item/medical/cat_tail
	name = "Хвост кошки"
	description = "Центральное командование исчерпало запас мощных уборщиков труб. Можете ли вы отправить хвост кошки, чтобы помочь им?"
	reward = 3000
	wanted_types = list(/obj/item/organ/tail/cat)

/datum/bounty/item/medical/chainsaw
	name = "Циркулярная пила"
	description = "У СМО в ЦК проблемы с операцией на големамах. Она просит одну бензопилу, пожалуйста."
	reward = 2500
	wanted_types = list(/obj/item/chainsaw,
						/obj/item/circular_saw)

/datum/bounty/item/medical/tail_whip //Like the cat tail bounties, with more processing.
	name = "Кнут девятихвостого"
	description = "Коммандер Джексон ищет прекрасное дополнение к своей коллекции экзотического оружия. Она щедро вознаградит вас за кнут из ящера или кота."
	reward = 4000
	wanted_types = list(/obj/item/melee/chainofcommand/tailwhip)

/datum/bounty/item/medical/surgerycomp
	name = "Хирургический компьютер"
	description = "После очередного странного инцидента с взрывом бомбы на нашем ежегодном сырном фестивале в ЦентКоме у нас уже собралась огромная группа раненых. Пожалуйста, пришлите нам новый хирургический компьютер, если это возможно."
	reward = 6000
	wanted_types = list(/obj/machinery/computer/operating)

/datum/bounty/item/medical/surgerytable
	name = "Операционный стол"
	description = "После недавнего притока зараженных членов экипажа мы увидели, что маски просто не режут его в одиночку. Серебряные операционные столы могут помочь, пришлите нам один для использования."
	reward = 3000
	wanted_types = list(/obj/structure/table/optable)
