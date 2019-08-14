//nutrition
/datum/mood_event/fat
	description = "<span class='warning'><B>�� ��� ������� ����...</B></span>\n" //muh fatshaming
	mood_change = -6

/datum/mood_event/wellfed
	description = "<span class='nicegreen'>��� ������� �����!</span>\n"
	mood_change = 8

/datum/mood_event/fed
	description = "<span class='nicegreen'>� �� ���� ����.</span>\n"
	mood_change = 5

/datum/mood_event/hungry
	description = "<span class='warning'>� ���� ����.</span>\n"
	mood_change = -6

/datum/mood_event/starving
	description = "<span class='boldwarning'>� �������!</span>\n"
	mood_change = -10

//charge
/datum/mood_event/charged
	description = "<span class='nicegreen'>� �������� ������������� � ���� �����!</span>\n"
	mood_change = 6

/datum/mood_event/lowpower
	description = "<span class='warning'>��� ������� �������������, ����� ���������� ���-������.</span>\n"
	mood_change = -6

/datum/mood_event/decharged
	description = "<span class='boldwarning'>� �������� �������� � �������������!</span>\n"
	mood_change = -10

//Disgust
/datum/mood_event/gross
	description = "<span class='warning'>��� ���� ���-�� �������.</span>\n"
	mood_change = -4

/datum/mood_event/verygross
	description = "<span class='warning'>�������, ���� ������.</span>\n"
	mood_change = -6

/datum/mood_event/disgusted
	description = "<span class='boldwarning'>�, ����, ��� ���� �������������.</span>\n"
	mood_change = -8

/datum/mood_event/disgust/bad_smell
	description = "<span class='warning'>� �������� ����� ����-�� ������ �������������� ������ ���� �������.</span>\n"
	mood_change = -6

/datum/mood_event/disgust/nauseating_stench
	description = "<span class='warning'>����� �������� ���� ���������!</span>\n"
	mood_change = -12

//Generic needs events
/datum/mood_event/favorite_food
	description = "<span class='nicegreen'>��� ���� ������.</span>\n"
	mood_change = 5
	timeout = 4 MINUTES

/datum/mood_event/gross_food
	description = "<span class='warning'>��� ���� ��������.</span>\n"
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/disgusting_food
	description = "<span class='warning'>��� ��� ���� �������������!</span>\n"
	mood_change = -6
	timeout = 4 MINUTES

/datum/mood_event/breakfast
	description = "<span class='nicegreen'>��� ������ ��������, ��� ������ ����� � ��������� ��������.</span>\n"
	mood_change = 2
	timeout = 10 MINUTES

/datum/mood_event/nice_shower
	description = "<span class='nicegreen'>�������� ���.</span>\n"
	mood_change = 4
	timeout = 5 MINUTES

/datum/mood_event/fresh_laundry
	description = "<span class='nicegreen'>��� ������ �����, ��� ������ ���������������� ����������.</span>\n"
	mood_change = 2
	timeout = 10 MINUTES
