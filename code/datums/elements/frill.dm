GLOBAL_LIST_EMPTY(frill_objects)


/proc/get_frill_object(icon_path, junction, shadow = FALSE, custom_alpha = 255, custom_plane = FRILL_PLANE, custom_pixel_x = -16, custom_pixel_y = -16)
	. = GLOB.frill_objects["[icon_path]-[junction]-[shadow]-[custom_alpha]-[custom_plane]-[custom_pixel_x]-[custom_pixel_y]"]
	if(.)
		return
	. = GLOB.frill_objects["[icon_path]-[junction]-[shadow]-[custom_alpha]-[custom_plane]-[custom_pixel_x]-[custom_pixel_y]"] = new /atom/movable/visual/frill(null, icon_path, junction, shadow, custom_alpha, custom_plane, custom_pixel_x, custom_pixel_y)


/**
  * Attached to smoothing atoms. Adds a globally-cached object to their vis_contents and updates based on junction changes.
  ** ATTENTION: This element was supposed to be for atoms, but since only movables and turfs actually have vis_contents hacks have to be done.
  ** For now it treats all of its targets as turfs, but that will runtime if an invalid variable access happens.
  ** Yes, this is ugly. The alternative is making two different elements for the same purpose.
  */
/datum/element/frill
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	id_arg_index = 2
	var/icon_path


/datum/element/frill/Attach(datum/target, icon_path)
	if(!isturf(target) && !ismovable(target)) // Turfs and movables have vis_contents. Atoms don't. Pain.
		return ELEMENT_INCOMPATIBLE
	. = ..()
	src.icon_path = icon_path
	var/turf/turf_or_movable = target
	turf_or_movable.vis_contents += get_frill_object(icon_path, turf_or_movable.smoothing_junction, TRUE)
	RegisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, .proc/on_junction_change)


/datum/element/frill/Detach(turf/target)
	target.vis_contents -= get_frill_object(icon_path, target.smoothing_junction, TRUE)
	UnregisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE)
	return ..()


/datum/element/frill/proc/on_junction_change(atom/source, new_junction)
	SIGNAL_HANDLER
	var/turf/turf_or_movable = source
	turf_or_movable.vis_contents -= get_frill_object(icon_path, turf_or_movable.smoothing_junction, TRUE)
	turf_or_movable.vis_contents += get_frill_object(icon_path, new_junction, TRUE)


/atom/movable/visual/frill
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	appearance_flags = NONE
	layer = ABOVE_MOB_LAYER
	plane = FRILL_PLANE
	vis_flags = NONE
	pixel_x = -16
	pixel_y = -16


/atom/movable/visual/frill/Initialize(mapload, icon, junction, shadow, custom_alpha, custom_plane, custom_pixel_x, custom_pixel_y)
	. = ..()
	src.icon = icon
	icon_state = "frill-[junction]"
	if(shadow)
		vis_contents += get_frill_object(icon, junction, FALSE, 120, UNDER_FRILL_PLANE, 0, 0)
	if(!isnull(custom_alpha))
		alpha = custom_alpha
	if(!isnull(custom_plane))
		plane = custom_plane
	if(!isnull(custom_pixel_x))
		pixel_x = custom_pixel_x
	if(!isnull(custom_pixel_y))
		pixel_y = custom_pixel_y
