/turf/closed/wall/r_wall
	name = "reinforced wall"
	desc = "����������� ���������� ����� �������, ������� ������ ��� ���������� ���������."
	icon = 'icons/turf/walls/reinforced_wall.dmi'
	icon_state = "r_wall"
	opacity = 1
	density = TRUE

	var/d_state = INTACT
	hardness = 10
	sheet_type = /obj/item/stack/sheet/plasteel
	sheet_amount = 1
	girder_type = /obj/structure/girder/reinforced
	explosion_block = 2
	rad_insulation = RAD_HEAVY_INSULATION

/turf/closed/wall/r_wall/deconstruction_hints(mob/user)
	switch(d_state)
		if(INTACT)
			return "<span class='notice'>������� <b>�������</b> ����.</span>"
		if(SUPPORT_LINES)
			return "<span class='notice'>������� <i>�������</i> ���������, ������ � ����� <b>���������</b>.</span>"
		if(COVER)
			return "<span class='notice'>�������������� ����� <i>���������</i>, ������������� �������� <b>���������</b> ������.</span>"
		if(CUT_COVER)
			return "<span class='notice'>������������� �������� <i>��������� ��������</i> � <b>���������</b> �� ���������.</span>"
		if(ANCHOR_BOLTS)
			return "<span class='notice'>������������� �������� <i>�����</i>, � ����� ����� �� ��� <b>����������</b> �� �����.</span>"
		if(SUPPORT_RODS)
			return "<span class='notice'>����� ������������ ������ <i>���������</i>, �� �� ��� <b>���������</b> ������ � ���������.</span>"
		if(SHEATH)
			return "<span class='notice'>�������������� ������ ����� <i>�������</i>, ���������� �������� <b>���������� �����</b> � ���������.</span>"

/turf/closed/wall/r_wall/devastate_wall()
	new sheet_type(src, sheet_amount)
	new /obj/item/stack/sheet/metal(src, 2)

/turf/closed/wall/r_wall/attack_animal(mob/living/simple_animal/M)
	M.changeNext_move(CLICK_CD_MELEE)
	M.do_attack_animation(src)
	if(!M.environment_smash)
		return
	if(M.environment_smash & ENVIRONMENT_SMASH_RWALLS)
		dismantle_wall(1)
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	else
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		to_chat(M, "<span class='warning'>��� ����� ������� ������ ��� ����.</span>")

/turf/closed/wall/r_wall/try_decon(obj/item/W, mob/user, turf/T)
	//DECONSTRUCTION
	switch(d_state)
		if(INTACT)
			if(W.tool_behaviour == TOOL_WIRECUTTER)
				W.play_tool_sound(src, 100)
				d_state = SUPPORT_LINES
				update_icon()
				to_chat(user, "<span class='notice'>�� ����������� ������� �������.</span>")
				return 1

		if(SUPPORT_LINES)
			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, "<span class='notice'>�� ��������� ����������� �������������� �����...</span>")
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_LINES)
						return 1
					d_state = COVER
					update_icon()
					to_chat(user, "<span class='notice'>�� ������������ �������������� �����.</span>")
				return 1

			else if(W.tool_behaviour == TOOL_WIRECUTTER)
				W.play_tool_sound(src, 100)
				d_state = INTACT
				update_icon()
				to_chat(user, "<span class='notice'>�� ������ ������� �������.</span>")
				return 1

		if(COVER)
			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=0))
					return
				to_chat(user, "<span class='notice'>�� ��������� ����������� ������������� ��������...</span>")
				if(W.use_tool(src, user, 60, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != COVER)
						return 1
					d_state = CUT_COVER
					update_icon()
					to_chat(user, "<span class='notice'>�� ������ ������ �� ���� � ��� ������� ������� �� �����.</span>")
				return 1

			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, "<span class='notice'>�� ��������� ������������ �������������� ����� �������...</span>")
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != COVER)
						return 1
					d_state = SUPPORT_LINES
					update_icon()
					to_chat(user, "<span class='notice'>�� ������������� �������������� �����.</span>")
				return 1

		if(CUT_COVER)
			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, "<span class='notice'>�� ��������� ����������� ��������...</span>")
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != CUT_COVER)
						return 1
					d_state = ANCHOR_BOLTS
					update_icon()
					to_chat(user, "<span class='notice'>�� ������������ ��������.</span>")
				return 1

			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=0))
					return
				to_chat(user, "<span class='notice'>�� ��������� ����������� �������� ������� �� �����...</span>")
				if(W.use_tool(src, user, 60, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != CUT_COVER)
						return TRUE
					d_state = COVER
					update_icon()
					to_chat(user, "<span class='notice'>�� ������������ ������������� �������� ������� �� �����.</span>")
				return 1

		if(ANCHOR_BOLTS)
			if(W.tool_behaviour == TOOL_WRENCH)
				to_chat(user, "<span class='notice'>�� ��������� ����������� ����� ������������ ������...</span>")
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != ANCHOR_BOLTS)
						return 1
					d_state = SUPPORT_RODS
					update_icon()
					to_chat(user, "<span class='notice'>�� ������������ ����� ������������ ������.</span>")
				return 1

			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, "<span class='notice'>�� ��������� ������� �������� ������� �� �����...</span>")
				if(W.use_tool(src, user, 20, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != ANCHOR_BOLTS)
						return 1
					d_state = CUT_COVER
					update_icon()
					to_chat(user, "<span class='notice'>�� ������� �������� ������� �� �����.</span>")
				return 1

		if(SUPPORT_RODS)
			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=0))
					return
				to_chat(user, "<span class='notice'>�� ��������� ��������� �������������� ������...</span>")
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_RODS)
						return 1
					d_state = SHEATH
					update_icon()
					to_chat(user, "<span class='notice'>�� ������������ ����� �������������� ������.</span>")
				return 1

			if(W.tool_behaviour == TOOL_WRENCH)
				to_chat(user, "<span class='notice'>�� ��������� ���������� ����� �������������� ������...</span>")
				W.play_tool_sound(src, 100)
				if(W.use_tool(src, user, 40))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_RODS)
						return 1
					d_state = ANCHOR_BOLTS
					update_icon()
					to_chat(user, "<span class='notice'>�� ����������� ����� �������������� ������.</span>")
				return 1

		if(SHEATH)
			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, "<span class='notice'>�� ��������� ����������� ������...</span>")
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SHEATH)
						return 1
					to_chat(user, "<span class='notice'>�� ������������ ������.</span>")
					dismantle_wall()
				return 1

			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=0))
					return
				to_chat(user, "<span class='notice'>�� ��������� ��������� �������������� ������ �������...</span>")
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SHEATH)
						return TRUE
					d_state = SUPPORT_RODS
					update_icon()
					to_chat(user, "<span class='notice'>�� ������������ �� ��� ����.</span>")
				return 1
	return 0

/turf/closed/wall/r_wall/update_icon()
	. = ..()
	if(d_state != INTACT)
		smooth = SMOOTH_FALSE
		clear_smooth_overlays()
	else
		smooth = SMOOTH_TRUE
		queue_smooth_neighbors(src)
		queue_smooth(src)

/turf/closed/wall/r_wall/update_icon_state()
	if(d_state != INTACT)
		icon_state = "r_wall-[d_state]"
	else
		icon_state = "r_wall"

/turf/closed/wall/r_wall/wall_singularity_pull(current_size)
	if(current_size >= STAGE_FIVE)
		if(prob(30))
			dismantle_wall()

/turf/closed/wall/r_wall/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.canRturf)
		return ..()


/turf/closed/wall/r_wall/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	if(the_rcd.canRturf)
		return ..()

/turf/closed/wall/r_wall/syndicate
	name = "hull"
	desc = "The armored hull of an ominous looking ship."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "map-shuttle"
	explosion_block = 20
	sheet_type = /obj/item/stack/sheet/mineral/plastitanium
	smooth = SMOOTH_MORE|SMOOTH_DIAGONAL
	canSmoothWith = list(/turf/closed/wall/r_wall/syndicate, /turf/closed/wall/mineral/plastitanium, /obj/machinery/door/airlock/shuttle, /obj/machinery/door/airlock, /obj/structure/window/plasma/reinforced/plastitanium, /obj/structure/shuttle/engine, /obj/structure/falsewall/plastitanium)

/turf/closed/wall/r_wall/syndicate/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	return FALSE

/turf/closed/wall/r_wall/syndicate/nodiagonal
	smooth = SMOOTH_MORE
	icon_state = "map-shuttle_nd"

/turf/closed/wall/r_wall/syndicate/nosmooth
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "wall"
	smooth = SMOOTH_FALSE

/turf/closed/wall/r_wall/syndicate/overspace
	icon_state = "map-overspace"
	fixed_underlay = list("space"=1)
