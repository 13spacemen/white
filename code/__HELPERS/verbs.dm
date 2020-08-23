/**
  * handles adding verbs and updating the stat panel browser
  *
  * pass the verb type path to this instead of adding it directly to verbs so the statpanel can update
  * Arguments:
  * * target - Who the verb is being added to, client or mob typepath
  * * verb - typepath to a verb, or a list of verbs, supports lists of lists
  */
/proc/add_verb(target, verb_or_list_to_add)
	if(!target)
		CRASH("add_verb called without a target")
	if(IsAdminAdvancedProcCall())
		return
	var/mob/M
	if(ismob(target))
		M = target
		if(!M.client)
			return
	else if(!istype(target, /client))
		CRASH("add_verb called on a non-mob and non-client")
	var/list/verbs_list = list()
	if(!islist(verb_or_list_to_add))
		verbs_list += verb_or_list_to_add
	else
		var/list/elements_to_process = verb_or_list_to_add
		while(length(elements_to_process))
			var/element_or_list = elements_to_process[length(elements_to_process)] //Last element
			elements_to_process.len--
			if(islist(element_or_list))
				elements_to_process += element_or_list //list/a += list/b adds the contents of b into a, not the reference to the list itself
			else
				verbs_list += element_or_list

	var/list/output_list = list()
	for(var/verb_to_add in verbs_list)
		target:verbs += verb_to_add // colon here so we don't have to check between client or mob, both MUST have a verbs var
		output_list[++output_list.len] = list("[verb_to_add:category]", "[verb_to_add:name]")
	output_list = url_encode(json_encode(output_list))
	if(M)
		M.client << output("[output_list];", "statbrowser:add_verb_list")
	else
		target << output("[output_list];", "statbrowser:add_verb_list")

/**
  * handles removing verb and sending it to browser to update, use this for removing verbs
  *
  * pass the verb type path to this instead of removing it from verbs so the statpanel can update
  * Arguments:
  * * target - Who the verb is being removed from, client or mob typepath
  * * verb - typepath to a verb, or a list of verbs, supports lists of lists
  */
/proc/add_verb(client/target, verb_or_list_to_remove)
	if(IsAdminAdvancedProcCall())
		return

	var/mob/mob_target = null

	if(ismob(target))
		mob_target = target
		target = mob_target.client
	else if(!istype(target, /client))
		CRASH("add_verb called on a non-mob and non-client")

	var/list/verbs_list = list()
	if(!islist(verb_or_list_to_remove))
		verbs_list += verb_or_list_to_remove
	else
		var/list/elements_to_process = verb_or_list_to_remove
		while(length(elements_to_process))
			var/element_or_list = elements_to_process[length(elements_to_process)] //Last element
			elements_to_process.len--
			if(islist(element_or_list))
				elements_to_process += element_or_list //list/a += list/b adds the contents of b into a, not the reference to the list itself
			else
				verbs_list += element_or_list

	if(mob_target)
		mob_target.verbs -= verbs_list
		if(!target)
			return //Our work is done.
	else
		target.verbs -= verbs_list

	var/list/output_list = list()
	for(var/verb_to_remove in verbs_list)
		output_list[++output_list.len] = list("[verb_to_remove:category]", "[verb_to_remove:name]")
	output_list = url_encode(json_encode(output_list))

	target << output("[output_list];", "statbrowser:remove_verb_list")
