/*
#define TOOL_COOKBOOK 		"cookbook"

/obj/item/book/cookbook
	name = "generic russian cookbook"
	desc = "������� ����� � �������� <<������� �����>> - �������� ��������� ���������� ������ ���������� ������������ ���������� �� �������, ���� � ������� �����."
	icon_state ="demonomicon"
	lefthand_file = 'icons/mob/inhands/misc/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/books_righthand.dmi'
	throw_speed = 1
	throw_range = 10
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	author = "Forces beyond your comprehension"
	unique = 1
	title = "the Russian Cookbook"
	tool_behaviour = TOOL_COOKBOOK
	dat = {"<html><body>
	<img src=https://pp.userapi.com/c306902/v306902481/11e6/7YOW5xnctHU.jpg>
	<br>
	<img src=https://pp.userapi.com/c306902/v306902481/1257/5swZEHEzVCs.jpg>
	<br>
	<img src=https://pp.userapi.com/c306902/v306902481/142e/YlRwVsqEQbY.jpg>
	<br>
	<img src=https://pp.userapi.com/c306902/v306902481/1480/6oFGL30v8DA.jpg>
	<br>
	<img src=https://pp.userapi.com/c306903/v306903481/2a80/074GF0u69Bo.jpg>
	<br>
	<img src=https://pp.userapi.com/c306903/v306903481/2cad/0TMt0vRWFEk.jpg>
	<br>
	<img src=https://pp.userapi.com/c319529/v319529481/227a/g0QZqwKnwIM.jpg>
	</body>
	</html>"}
*/

#define CAT_COOKBOOK	"Cookbook"

/obj/item/book/granter/crafting_recipe/cookbook
	name = "generic russian cookbook"
	desc = "������� ����� � �������� <<������� �����>> - �������� ��������� ���������� ������ ���������� ������������ ���������� �� �������, ���� � ������� �����."
	crafting_recipe_types = list(
								/datum/crafting_recipe/cookbook/mshotgun,
								/datum/crafting_recipe/cookbook/mshotgunmag,
								/datum/crafting_recipe/cookbook/npgrenade,
								/datum/crafting_recipe/cookbook/grenadeprimer

								)
/datum/uplink_item/cookbook
	name = "Cookbook"
	category = "Devices and Tools"
	desc = "����� ���������� � �������������� �����."
	item = /obj/item/book/granter/crafting_recipe/cookbook
	cost = 2
	surplus = 10

/datum/crafting_recipe/cookbook
	always_availible = FALSE
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/cookbook/mshotgun
	name = "Makeshift Shotgun"
	result = /obj/item/gun/ballistic/automatic/shotgun/small/makeshift
	reqs = list(/obj/item/weaponcrafting/receiver = 1,
				/obj/item/pipe = 1,
				/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/rods = 5)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WRENCH)
	time = 300

/datum/crafting_recipe/cookbook/mshotgunmag
	name = "Makeshift Shotgun magazine"
	result = /obj/item/ammo_box/magazine/m4s12g
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/rods = 4)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WRENCH)
	time = 100
	subcategory = CAT_AMMO

/datum/crafting_recipe/cookbook/npgrenade
	name = "Neuroparalitic gas grenade"
	result = /obj/item/grenade/chem_grenade/npgrenade
	reqs = list(/datum/reagent/toxin/mindbreaker = 10,
				/datum/reagent/drug/krokodil = 10,
				/datum/reagent/consumable/ethanol/vodka = 5,
				/obj/item/grenade/smokebomb = 1)
//	parts = list()
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WRENCH)
	time = 100

/datum/crafting_recipe/cookbook/grenadeprimer
	name = "Grenade primer"
	result = /obj/item/assembly/primer
	reqs = list(/obj/item/assembly/igniter = 1,
				/obj/item/stock_parts/manipulator = 2,
				/obj/item/stack/cable_coil = 20)
//	parts = list()
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 100