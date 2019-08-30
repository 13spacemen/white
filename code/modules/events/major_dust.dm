/datum/round_event_control/meteor_wave/major_dust
	name = "Major Space Dust"
	typepath = /datum/round_event/meteor_wave/major_dust
	weight = 8

/datum/round_event/meteor_wave/major_dust
	wave_name = "space dust"

/datum/round_event/meteor_wave/major_dust/announce(fake)
	var/reason = pick(
		"������� �������� ������ ������ ������, ��������� �������������� ����������� �������� ������������ � ����������.",
		"������������� ����������� ������������ �������� ��������� ������ ��������� [pick("��������������","���������","��������","�����-������������","����������")] \
		[pick("�����","����������","������","���������� �������","\[REDACTED\]")], \
		��������� ��������� �����.",
		"�������� ������� ������� � ��� �����. (��������, ��� ������ �� ����� ���������.)")
	priority_announce(pick(reason), "��������� ������������")
