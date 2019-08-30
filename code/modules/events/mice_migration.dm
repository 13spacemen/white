/datum/round_event_control/mice_migration
	name = "Mice Migration"
	typepath = /datum/round_event/mice_migration
	weight = 10

/datum/round_event/mice_migration
	var/minimum_mice = 5
	var/maximum_mice = 15

/datum/round_event/mice_migration/announce(fake)
	var/cause = pick("���������", "�������� ��������", "��������",
		"��������� �������", "\[REDACTED\]", "��������� �������",
		"���������")
	var/plural = pick("������", "����", "�����", "���",
		"�����", "�� ����� ��� �� [maximum_mice]")
	var/name = pick("��������", "�����", "������� ����",
		"����������� ��������", "\[REDACTED\]", "�������������� ������������� �������")
	var/movement = pick("�����������", "���������", "���������", "����������")
	var/location = pick("����������� �������", "����������� ����",
		"\[REDACTED\]", "�����, ��� ��������� ������� �������")

	priority_announce("�� ������� [cause], [plural] [name] [movement] \
		� [location].", "������������ �������",
		'sound/effects/mousesqueek.ogg')

/datum/round_event/mice_migration/start()
	SSminor_mapping.trigger_migration(rand(minimum_mice, maximum_mice))
