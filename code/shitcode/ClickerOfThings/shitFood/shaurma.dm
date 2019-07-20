/obj/item/reagent_containers/food/snacks/customizable/shaurma
	name = "shaurma"
	desc = "Popular middle-east food. Very tasty."
	icon = 'code/shitcode/ClickerOfThings/shitFood/shaurma.dmi'
	icon_state = "shaurma"
	ingMax = 6
	foodtype = MEAT | VEGETABLES
	lefthand_file = 'code/shitcode/ClickerOfThings/shitFood/shaurma_left.dmi'
	righthand_file = 'code/shitcode/ClickerOfThings/shitFood/shaurma_right.dmi'


/obj/item/reagent_containers/food/snacks/store/shaurma
	name = "shaurma filling"
	desc = "Filling for shaurma."
	icon = 'code/shitcode/ClickerOfThings/shitFood/shaurma.dmi'
	icon_state = "shaurma"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 7)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	custom_food_type = /obj/item/reagent_containers/food/snacks/customizable/shaurma
	tastes = list("torilla" = 2, "meat" = 3)
	foodtype = MEAT | VEGETABLES

/datum/crafting_recipe/food/shaurma
	name = "Shaurma filling"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/flatdough = 3,
	)
	result = /obj/item/reagent_containers/food/snacks/store/shaurma
	subcategory = CAT_MISCFOOD
