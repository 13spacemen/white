/datum/interaction/kiss
	command = "kiss"
	description = "����������."
	require_user_mouth = 1
	simple_message = "USER ������ TARGET."
	write_log_user = "kissed"
	write_log_target = "was kissed by"
	needs_physical_contact = 1

datum/interaction/kiss/evaluate_user(var/mob/user, var/silent=1)
	if(..())
		if(!user.has_lips())
			if(!silent) user << "<span class='warning'>� ���� ��� ���!</span>"
			return 0
		return 1
	return 0

/datum/interaction/cheer
	command = "cheer"
	description = "����������."
	require_user_mouth = 1
	simple_message = "USER ������������ TARGET!"

/datum/interaction/highfive
	command = "highfive"
	description = "���� ����."
	require_user_mouth = 1
	simple_message = "USER ��� ������ TARGET!"
	interaction_sound = 'code/shitcode/valtos/ohgod/sounds/interactions/slap.ogg'
	needs_physical_contact = 1

/datum/interaction/fistbump
	command = "fistbump"
	description = "�������!"
	require_user_hands = 1
	simple_message = "USER ������ ������� � TARGET! � ��!"
	needs_physical_contact = 1

/datum/interaction/holdhand
	command = "holdhand"
	description = "��������� �� ����."
	require_user_hands = 1
	simple_message = "USER ������ TARGET �� ����."
	max_distance = 25
	needs_physical_contact = 1
	max_distance = 25
