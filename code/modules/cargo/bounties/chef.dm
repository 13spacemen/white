/datum/bounty/item/chef/birthday_cake
	name = "Праздничный торт"
	description = "Скоро День рождения НТ! Отправьте им праздничный торт на день рождения!"
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/food/cake/birthday, /obj/item/food/cakeslice/birthday)

/datum/bounty/item/chef/soup
	name = "Суп"
	description = "Чтобы подавить восстание бездомных, НТ будет разносить суп всем работникам с недостаточной оплатой. Отправьте им любой вид супа."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 3
	wanted_types = list(/obj/item/food/soup)

/datum/bounty/item/chef/popcorn
	name = "Попкорн"
	description = "Высшее руководство хочет провести вечер в кино. Отправьте им мешки с попкорном по этому случаю."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 3
	wanted_types = list(/obj/item/food/popcorn)

/datum/bounty/item/chef/onionrings
	name = "Луковые кольца"
	description = "НТ вспоминает день Сатурна. Отправьте кольца лука, чтобы показать поддержку станции."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 3
	wanted_types = list(/obj/item/food/onionrings)

/datum/bounty/item/chef/icecreamsandwich
	name = "Бутерброды с мороженным" // бутерброд это кринж полнейший
	description = "Высшее руководство безостановочно нуждается в мороженном. Пожалуйста, пришлите им немного."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 3
	wanted_types = list(/obj/item/food/icecreamsandwich)

/datum/bounty/item/chef/strawberryicecreamsandwich
	name = "Бутерброд с клубничным мороженным"
	description = "Высшее руководство безостановочно кричит о более ароматном мороженом. Пожалуйста, пришлите немного."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/food/strawberryicecreamsandwich)

/datum/bounty/item/chef/bread
	name = "Хлебушек"
	description = "Проблемы с центральным планированием привели к резкому росту цен на хлеб. Отправьте немного хлеба, чтобы ослабить напряженность."
	reward = CARGO_CRATE_VALUE * 2
	wanted_types = list(/obj/item/food/bread, /obj/item/food/breadslice, /obj/item/food/bun, /obj/item/food/pizzabread, /obj/item/food/rawpastrybase)

/datum/bounty/item/chef/pie
	name = "Пирог"
	description = "3,14159? Нет! Руководство ЦК хочет съесть пирог! Отправьте им целый пирог."
	reward = 314
	wanted_types = list(/obj/item/food/pie)

/datum/bounty/item/chef/salad
	name = "Салад или рисовые миски"
	description = "ЦК переживает негодование. Ваш заказ состоит в том, чтобы отправить салат или рисовые миски."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 3
	wanted_types = list(/obj/item/food/salad)

/datum/bounty/item/chef/carrotfries
	name = "Морковка-Фри" // картошка-фри? Блять... как же сложно быть украинцем когда ты в душе хз как это звучит на русском...
	description = "Ночное зрение может означать жизнь или смерть! Поставка морковки-фри является заказом."
	reward = CARGO_CRATE_VALUE * 7
	required_count = 3
	wanted_types = list(/obj/item/food/carrotfries)

/datum/bounty/item/chef/superbite
	name = "Супер кусок бургера"
	description = "Командующий Таббс считает, что он может установить конкурентоспособный мировой рекорд в еде. Все, что ему нужно, это супер кусочек бургера, отправленный ему."
	reward = CARGO_CRATE_VALUE * 24
	wanted_types = list(/obj/item/food/burger/superbite)

/datum/bounty/item/chef/poppypretzel
	name = "Крендель с маком"
	description = "ЦК нужна причина, чтобы уволить их HR-руководителя. Отправьте крендель с маком, чтобы устроить проваленный тест на наркотики."
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/food/poppypretzel)

/datum/bounty/item/chef/cubancarp
	name = "Кубинский карп "
	description = "Чтобы отпраздновать рождение Кастро XXVII, отправьте одного кубинского карпа на ЦК."
	reward = CARGO_CRATE_VALUE * 16
	wanted_types = list(/obj/item/food/cubancarp)

/datum/bounty/item/chef/hotdog
	name = "Хот-Дог"
	description = "НТ проводит вкусовые тесты, чтобы определить лучший рецепт хот-дога. Отправьте версию своего хот-дога станции для участия."
	reward = CARGO_CRATE_VALUE * 16
	wanted_types = list(/obj/item/food/hotdog)

/datum/bounty/item/chef/eggplantparm
	name = "Пармиджано"
	description = "Знаменитая певица скоро прибудет на ЦК, и их контракт требует, чтобы их обслуживали только баклажанами пермиджано. Отправьте их на ЦК!"
	reward = CARGO_CRATE_VALUE * 7
	required_count = 3
	wanted_types = list(/obj/item/food/eggplantparm)

/datum/bounty/item/chef/muffin
	name = "Кексы"
	description = "Человек Кекс посещает ЦК, но он забыл свои кексы! Ваш заказ должен исправить это!"
	reward = CARGO_CRATE_VALUE * 6
	required_count = 3
	wanted_types = list(/obj/item/food/muffin)

/datum/bounty/item/chef/chawanmushi
	name = "Тяван-муси"
	description = "НТ хочет улучшить отношения со своей дочерней компанией Japan'o'Trasen. Отправьте тяван-муси немедленно."
	reward = CARGO_CRATE_VALUE * 16
	wanted_types = list(/obj/item/food/chawanmushi)

/datum/bounty/item/chef/kebab
	name = "Кебаб"
	description = "Уберите весь кебаб со станции, вы - лучшая еда. Отправьте на ЦК для утилизации."
	reward = CARGO_CRATE_VALUE * 7
	required_count = 3
	wanted_types = list(/obj/item/food/kebab)

/datum/bounty/item/chef/soylentgreen
	name = "Зелёный сойлент"
	description = "ЦК слышали замечательные вещи о продукте «Зелёный сойлент» и хотели бы попробовать его. Если вы их отправили, ожидайте приятного бонуса."
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(/obj/item/food/soylentgreen)

/datum/bounty/item/chef/pancakes
	name = "Блины"
	description = "Здесь, в НТ, мы считаем сотрудников семьей. А вы знаете, что любят семьи? Блины. Отправь дюжину блинов."
	reward =  CARGO_CRATE_VALUE * 10
	required_count = 13
	wanted_types = list(/obj/item/food/pancakes)

/datum/bounty/item/chef/nuggies
	name = "Куриные наггетсы"
	description = "Сын вице-президента не перестаёт говорить про куриные наггетсы. Не могли бы вы отправить ему немного?"
	reward = CARGO_CRATE_VALUE * 8
	required_count = 6
	wanted_types = list(/obj/item/food/nugget)

/datum/bounty/item/chef/corgifarming //Butchering is a chef's job.
	name = "Шкура Корги"
	description = "Космической яхте адмирала Вайнштейна нужна новая обивка. Дюжина меха корги подойдет."
	reward = CARGO_CRATE_VALUE * 60 //that's a lot of dead dogs
	required_count = 12
	wanted_types = list(/obj/item/stack/sheet/animalhide/corgi)
