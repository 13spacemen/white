/obj/forge
	name = "кузница"
	desc = "Нагревает различные штуки, но реже всего слитки."
	icon = 'white/valtos/icons/dwarfs/forge.dmi'
	icon_state = "forge_on"
	light_range = 9
	light_color = "#BB661E"
	density = TRUE
	anchored = TRUE

/obj/forge/attackby(obj/item/I, mob/living/user, params)

	if(user.a_intent == INTENT_HARM)
		return ..()

	if(istype(I, /obj/item/blacksmith/tongs))
		if(I.contents.len)
			if(istype(I.contents[I.contents.len], /obj/item/blacksmith/ingot))
				var/obj/item/blacksmith/ingot/N = I.contents[I.contents.len]
				N.heattemp = 350
				I.icon_state = "tongs_hot"
				to_chat(user, "<span class='notice'>Нагреваю болванку как могу.</span>")
				return
		else
			to_chat(user, "<span class='warning'>Ты ебанутый?</span>")
			return

/obj/furnace
	name = "плавильня"
	desc = "Плавит."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "furnace"
	density = TRUE
	anchored = TRUE
	light_range = 0
	light_color = "#BB661E"
	var/furnacing = FALSE
	var/furnacing_type = "iron"

/obj/furnace/proc/furnaced_thing()
	icon_state = "furnace"
	furnacing = FALSE
	light_range = 0

	switch(furnacing_type)
		if("iron")
			new /obj/item/blacksmith/ingot(drop_location())
		if("gold")
			new /obj/item/blacksmith/ingot/gold(drop_location())
		if("glass")
			new /obj/item/stack/sheet/glass/five(drop_location())

/obj/furnace/attackby(obj/item/I, mob/living/user, params)

	if(user.a_intent == INTENT_HARM)
		return ..()

	if(furnacing)
		to_chat(user, "<span class=\"alert\">Плавильня занята работой!</span>")
		return

	if(istype(I, /obj/item/stack/ore/iron) || istype(I, /obj/item/stack/ore/gold) || istype(I, /obj/item/stack/sheet/metal) || istype(I, /obj/item/stack/ore/glass))
		var/obj/item/stack/S = I
		if(S.amount >= 5)
			S.use(5)
			furnacing = TRUE
			icon_state = "furnace_on"
			light_range = 3
			to_chat(user, "<span class='notice'>Плавильня начинает свою работу...</span>")
			if(istype(I, /obj/item/stack/ore/gold))
				furnacing_type = "gold"
			else if(istype(I, /obj/item/stack/ore/glass))
				furnacing_type = "glass"
			else
				furnacing_type = "iron"
			addtimer(CALLBACK(src, .proc/furnaced_thing), 15 SECONDS)
		else
			to_chat(user, "<span class=\"alert\">Нужно примерно пять единиц руды для создания слитка.</span>")

/obj/anvil
	name = "наковальня"
	desc = "Вот на этом удобно ковать, да?"
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "anvil"
	density = TRUE
	var/acd = FALSE
	var/obj/item/blacksmith/ingot/current_ingot = null
	var/list/allowed_things = list()

/obj/anvil/Topic(href, list/href_list)
	. = ..()
	if(.)
		return .
	if(href_list["hit"])
		hit(usr)
	if(href_list["miss"])
		miss(usr)

/obj/anvil/proc/hit(mob/user)
	var/mob/living/carbon/human/H = user
	if(current_ingot.progress_current == current_ingot.progress_need)
		current_ingot.progress_current++
		playsound(src, 'white/valtos/sounds/anvil_hit.ogg', 70, TRUE)
		to_chat(user, "<span class='notice'>Болванка готова. Ещё один удар для продолжения ковки, либо можно охлаждать.</span>")
		to_chat(user, "<span class='green'>> Активируй болванку в клещах для охлаждения.</span>")
		user<<browse(null, "window=Наковальня")
		return
	else
		playsound(src, 'white/valtos/sounds/anvil_hit.ogg', 70, TRUE)
		user.visible_message("<span class='notice'><b>[user]</b> бьёт молотом по наковальне.</span>", \
						"<span class='notice'>Бью молотом по наковальне.</span>")
		current_ingot.progress_current++
		H.adjustStaminaLoss(rand(1, 5))
		H.mind.adjust_experience(/datum/skill/smithing, rand(0, 4) * current_ingot.mod_grade)
		return

/obj/anvil/proc/miss(mob/user)
	// var/mob/living/carbon/human/H = user
	current_ingot.durability--
	if(current_ingot.durability == 0)
		to_chat(user, "<span class='warning'>Болванка раскалывается на множество бесполезных кусочков металла...</span>")
		current_ingot = null
		LAZYCLEARLIST(contents)
		icon_state = "[initial(icon_state)]"
		user<<browse(null, "window=Наковальня")
	playsound(src, 'white/valtos/sounds/anvil_hit.ogg', 70, TRUE)
	user.visible_message("<span class='warning'><b>[user]</b> неправильно бьёт молотом по наковальне.</span>", \
						"<span class='warning'>Неправильно бью молотом по наковальне.</span>")
	return

/obj/anvil/fullsteel
	name = "тяжёлая наковальня"
	desc = "Не сдвинуть. Совсем."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "anvil_full"

/obj/anvil/Initialize()
	. = ..()
	for(var/item in subtypesof(/datum/smithing_recipe))
		var/datum/smithing_recipe/SR = new item()
		allowed_things += SR

/obj/anvil/attackby(obj/item/I, mob/living/user, params)

	if(user.a_intent == INTENT_HARM)
		return ..()

	if(acd)
		return

	if(!ishuman(user))
		to_chat(user, "<span class='warning'>Мои ручки слишком слабы для такой работы!</span>")
		return

	var/mob/living/carbon/human/H = user

	acd = TRUE
	addtimer(VARSET_CALLBACK(src, acd, FALSE), H.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) SECONDS)

	if(istype(I, /obj/item/blacksmith/smithing_hammer))
		if(current_ingot)
			if(current_ingot.heattemp <= 0)
				icon_state = "[initial(icon_state)]_cold"
				to_chat(user, "<span class='warning'>Болванка слишком холодная. Стоит разогреть её.</span>")
				return
			if(current_ingot.recipe)
				var/height = 30
				var/dat = {"<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Наковальня</title>
    <style>* { padding: 0; margin: 0; } canvas { background: #eee; display: block; margin: 0 auto; }</style>
</head>
<body>
<div>
<canvas id="myCanvas" width="300" height="62" style="left: 50%;"></canvas>
<button onclick="ClickButton()" style="transform: translate(-50%);left: 50%;position: relative;">Ударить</button>
</div>
<script>
    function ClickButton(){
        if(collision() && !cooldown){
            score++;
            cooldownlast=0;
            cooldown=true;
			window.location = ("byond://?src=[REF(src)];hit=1")
        }
        else if (!collision() && !cooldown){
            lives--;
            cooldownlast=0;
            cooldown=true;
			window.location = ("byond://?src=[REF(src)];miss=1")
        }
    }

    let canvas = document.getElementById("myCanvas");
    let ctx = canvas.getContext("2d");
    let linewidth = 1
    let x = 0
	let speed = [1+current_ingot.mod_grade/2];
    let right = true;
    let cooldown = false;
    let cooldownlast = 0
    let score = 0;
    let lives = 3;
    let fieldwidth = [20+H.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SMITHING_MODIFIER)];
    let cooldown_m = 60;


    function collision() {
        if((canvas.width/2-fieldwidth/2)<x&& x<(canvas.width/2+fieldwidth/2)){
            // console.log("collision")
            return true
        }
        else{
            // console.log("uncolision")
            return false
        }
    }

    function drawfield(color){
        ctx.beginPath();
        ctx.rect(canvas.width/2-fieldwidth/2, 32, fieldwidth, 30);
        ctx.fillStyle = color;
        ctx.opacity = 0.1
        ctx.fill();
        ctx.closePath();
    }

    function drawline(){
        ctx.beginPath();
        ctx.rect(x, 32, linewidth, 30);
        ctx.fillStyle = "#FF2133";
        ctx.fill();
        ctx.closePath();
    }

    function drawScore() {
        ctx.font = "16px Arial";
        ctx.fillStyle = "#0095DD";
        ctx.fillText("Ударов: "+score, 115, 20);
    }

    function checkcooldown(){
        // console.log(cooldownlast)
        if(cooldownlast>cooldown_m){
            cooldown = false;
        }
        else{
            cooldown = true;
        }
    }
	function drawSep(){
        ctx.beginPath();
        ctx.rect(0, 30, canvas.width, 2);
        ctx.fillStyle = "black";
        ctx.fill();
        ctx.closePath();
    }

    function draw() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        if(collision()){
            drawfield("green")
        }
        else{
            drawfield("red")
        }
        drawline();
        drawScore();
		drawSep();
        // console.log(x)
        checkcooldown()
        cooldownlast++;
        if(right && x<canvas.width){
            x+=speed;
        }
        else if(right && x==canvas.width){
            right = !right
        }
        if(!right && x>0){
            x-=speed;
        }
        else if(!right && x==0){
            right = !right
        }

        requestAnimationFrame(draw);
    }

    draw()


</script>
</body>
</html>"}
				if(current_ingot.progress_current <= current_ingot.progress_need)
					var/datum/browser/popup = new(user, "Наковальня", "Наковальня", 500, height+120)
					popup.set_content(dat)
					popup.open()
				if(current_ingot.progress_current > current_ingot.progress_need)
					current_ingot.progress_current = 0
					current_ingot.mod_grade++
					current_ingot.progress_need = round(current_ingot.progress_need * 1.1)
					playsound(src, 'white/valtos/sounds/anvil_hit.ogg', 70, TRUE)
					to_chat(user, "<span class='notice'>Начинаем улучшать болванку...</span>")
					return
			else
				var/list/metal_allowed_list = list()
				for(var/datum/smithing_recipe/SR in allowed_things)
					if(SR.metal_type_need == current_ingot.type_metal)
						metal_allowed_list += SR
				var/datum/smithing_recipe/sel_recipe = input("Выбор:", "Что куём?", null, null) as null|anything in metal_allowed_list
				if(!sel_recipe)
					to_chat(user, "<span class='warning'>Не выбран рецепт.</span>")
					return
				if(current_ingot.recipe)
					to_chat(user, "<span class='warning'>УЖЕ ВЫБРАН РЕЦЕПТ!</span>")
					return
				current_ingot.recipe = new sel_recipe.type()
				current_ingot.recipe.max_resulting = H.mind.get_skill_modifier(/datum/skill/smithing, SKILL_RANDS_MODIFIER)
				playsound(src, 'white/valtos/sounds/anvil_hit.ogg', 70, TRUE)
				to_chat(user, "<span class='notice'>Приступаем к ковке...</span>")
				return
		else
			to_chat(user, "<span class='warning'>Тут нечего ковать!</span>")
			return

	if(istype(I, /obj/item/blacksmith/tongs))
		if(current_ingot)
			if(I.contents.len)
				to_chat(user, "<span class='warning'>Клещи уже что-то держат!</span>")
				return
			else
				if(current_ingot.heattemp > 0)
					I.icon_state = "tongs_hot"
				else
					I.icon_state = "tongs_cold"
				current_ingot.forceMove(I)
				current_ingot = null
				icon_state = "[initial(icon_state)]"
				to_chat(user, "<span class='notice'>Беру болванку в клещи.</span>")
				return
		else
			if(I.contents.len)
				if(current_ingot)
					to_chat(user, "<span class='warning'>Здесь уже есть болванка!</span>")
					return
				var/obj/item/blacksmith/ingot/N = I.contents[I.contents.len]
				if(N.heattemp > 0)
					icon_state = "[initial(icon_state)]_hot"
				else
					icon_state = "[initial(icon_state)]_cold"
				N.forceMove(src)
				current_ingot = N
				I.icon_state = "tongs"
				to_chat(user, "<span class='notice'>Располагаю болванку на наковальне.</span>")
				return
			else
				to_chat(user, "<span class='warning'>Наковальня совсем пуста!</span>")
				return
	return ..()
