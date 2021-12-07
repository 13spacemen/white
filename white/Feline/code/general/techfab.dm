//Фабрикаторы

/**
 * Для корректной работы у /datum/design/предмет должен быть флаг build_type = MECHFAB (можно совмещать с другими)
 * Так же должен быть проставлен category = list() в соответствии с пунктами фабрикатора. Если такого пункта нет - отображатся он там не будет
 * Флагов отделов у фабрикатора нет, поэтому все пункты в разных фабрикаторах должны быть уникальными или будет дубликация (если это и не есть цель)
 * Для подкласса необходимо проставить в датумах sub_category = list() если этого не сделать, то отображение будет в виде общего списка с названием "Снаряжение"
 * Для создание новых подклассов объявлять их не нужно, достаточно лишь вписать новое значение в датум предмета, после чего он сгруппирует их со схожими.
 * Порядок отображения подклассов зависит от порядка исследования в нодах, стартовые можно менять смещая их относительно друг друга.
 */
/obj/machinery/mecha_part_fabricator/med
	icon = 'white/Feline/icons/techfab.dmi'
	icon_state = "fab-idle"
	name = "медицинский фабрикатор"
	desc = "Используется для создания медицинского оборудования."
	circuit = /obj/item/circuitboard/machine/mechfab/med
	drop_zone = FALSE
	part_sets = list(											// Подклассы:
								"Хирургические инструменты",	// "Базовые инструменты", "Продвинутые инструменты", "Инопланетные инструменты", "Прочее"
								"Медицинское снаряжение",		// "Диагностика и мониторинг", "Прочее"
								"Фармацевтика",					// "Химическая посуда", "Инъекции", "Хим-фабрика", "Прочее"
								"Кибернетика",					// "Базовые кибернетические органы", "Протезирование", "Стандартные кибернетические органы", "Продвинутые кибернетические органы", "Сенсорика"
								"Импланты",						// "Кибер Импланты", "Микро Импланты", "Дополненая реальность"
								"Медицинское оборудование",		// "Криостазис", "Химпроизводство", "Автохирургия", "Реанимация и хирургия", "Биоманипулирование", "Прочее"
								"Вооружение",					//
								"Прочее"						//
								)

/obj/item/circuitboard/machine/mechfab/med
	name = "Плата Медицинского фабрикатора"
	desc = "Продвинутая версия протолата с удобным визуальным интерфейсом."
	icon_state = "medical"
	build_path = /obj/machinery/mecha_part_fabricator/med

/obj/machinery/mecha_part_fabricator/med/Initialize()
	. = ..()
	add_overlay("med")

