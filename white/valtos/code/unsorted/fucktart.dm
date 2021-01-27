/client/proc/raspidoars()
	set name = " ? Raspidoars"
	set category = "Дбг"

	var/turf/where = get_turf(mob)

	if(!where)
		return

	var/rss = input("Raspidoars range (Tiles):") as num

	for(var/atom/A in spiral_range(rss, where))
		if(isturf(A) || isobj(A) || ismob(A))
			playsound(where, 'white/valtos/sounds/bluntcreep.ogg', 100, TRUE, rss)
			var/matrix/M = A.transform
			M.Scale(rand(1, 2), rand(1, 2))
			M.Translate(rand(-2, 2), rand(-2, 2))
			M.Turn(rand(-90, 90))
			A.color = "#[random_short_color()]"
			animate(A, color = color_matrix_rotate_hue(rand(0, 360)), time = rand(200, 500), easing = CIRCULAR_EASING, flags = ANIMATION_PARALLEL)
			animate(A, transform = M, time = rand(200, 1000), flags = ANIMATION_PARALLEL)
			sleep(pick(0.3, 0.5, 0.7))

/client/proc/kaboom()
	set name = " ? Ka-Boom"
	set category = "Дбг"

	var/turf/where = get_turf(mob)

	if(!where)
		return

	var/rss = input("Ka-Boom range (Tiles):") as num

	var/list/AT = circlerangeturfs(where, rss)

	var/x0 = where.x
	var/y0 = where.y

	for(var/turf/T in AT)
		var/dist = max(1, cheap_hypotenuse(T.x, T.y, x0, y0))

		var/matrix/M = T.transform
		M.Scale(dist, dist)
		spawn(dist*2)
			animate(T, transform = M, time = 5, easing = BOUNCE_EASING)
			animate(transform = null, time = 5, easing = BOUNCE_EASING)

/client/proc/smooth_fucking_z_level()
	set name = " ? Smooth Z-Level"
	set category = "Дбг"

	var/zlevel = input("Z-Level? Пиши 0, если не понимаешь че нажал:") as num

	if(zlevel != 0)
		smooth_zlevel(zlevel, now = FALSE)
		message_admins("[ADMIN_LOOKUPFLW(usr)] запустил процесс сглаживания Z-уровня [zlevel].")
		log_admin("[key_name(usr)] запустил процесс сглаживания Z-уровня [zlevel].")
