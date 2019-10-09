/datum/mood_event/hug
	description = "<span class='nicegreen'>��������� - �����.</span>\n"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/betterhug
	description = "<span class='nicegreen'>���-�� ����� ���� �� ���.</span>\n"
	mood_change = 3
	timeout = 4 MINUTES

/datum/mood_event/betterhug/add_effects(mob/friend)
	description = "<span class='nicegreen'>[friend.name] ����� ���� ���� ����.</span>\n"

/datum/mood_event/besthug
	description = "<span class='nicegreen'>����� � ���-�� ����� ������� ���������, ��� ��� ������ � ���!</span>\n"
	mood_change = 5
	timeout = 4 MINUTES

/datum/mood_event/besthug/add_effects(mob/friend)
	description = "<span class='nicegreen'>[friend.name] ����� ���� ���� ����, ����� � [friend.p_they()] ��� ������ ����������!</span>\n"

/datum/mood_event/arcade
	description = "<span class='nicegreen'>� ���� ���������� ������ ����!</span>\n"
	mood_change = 3
	timeout = 8 MINUTES

/datum/mood_event/blessing
	description = "<span class='nicegreen'>���� ������������.</span>\n"
	mood_change = 3
	timeout = 8 MINUTES

/datum/mood_event/book_nerd
	description = "<span class='nicegreen'>��� ���� ������� ������.</span>\n"
	mood_change = 1
	timeout = 5 MINUTES

/datum/mood_event/exercise
	description = "<span class='nicegreen'>������ � ��������� ��������� ����������!</span>\n"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/pet_animal
	description = "<span class='nicegreen'>�������� ����� �����! �� ���� ��������� �� �������!</span>\n"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/pet_animal/add_effects(mob/animal)
	description = "<span class='nicegreen'>[animal.name] ����� �����! � �� ���� ��������� ������� [animal.p_them()]!</span>\n"

/datum/mood_event/honk
	description = "<span class='nicegreen'>���� ��������!/span>\n"
	mood_change = 2
	timeout = 4 MINUTES
	special_screen_obj = "honked_nose"
	special_screen_replace = FALSE

/datum/mood_event/perform_cpr
	description = "<span class='nicegreen'>��� ������� ������ ���-�� �����.</span>\n"
	mood_change = 6
	timeout = 8 MINUTES

/datum/mood_event/oblivious
	description = "<span class='nicegreen'>����� ���������� ����..</span>\n"
	mood_change = 3

/datum/mood_event/jolly
	description = "<span class='nicegreen'>��� ������ ��� �����-���� �������.</span>\n"
	mood_change = 6
	timeout = 2 MINUTES

/datum/mood_event/focused
	description = "<span class='nicegreen'>� ���� ���� ����, � � ������� �, �� ��� �� �� �� �����!</span>\n" //Used for syndies, nukeops etc so they can focus on their goals
	mood_change = 4
	hidden = TRUE

/datum/mood_event/badass_antag
	description = "<span class='greentext'>� ��� ����, � ��� ��� �����. ������ �������� �� ���, ��� �������� �� ����� �����, ��� � ����� � ����.</span>\n"
	mood_change = 7
	hidden = TRUE
	special_screen_obj = "badass_sun"
	special_screen_replace = FALSE

/datum/mood_event/creeping
	description = "<span class='greentext'>������ ���������� ����!</span>\n" //creeps get it when they are around their obsession
	mood_change = 18
	timeout = 3 SECONDS
	hidden = TRUE

/datum/mood_event/revolution
	description = "<span class='nicegreen'>����� ���������!!!</span>\n"
	mood_change = 3
	hidden = TRUE

/datum/mood_event/cult
	description = "<span class='nicegreen'>� ���� ������, ������ ��������!</span>\n"
	mood_change = 10 //maybe being a cultist isnt that bad after all
	hidden = TRUE

/datum/mood_event/family_heirloom
	description = "<span class='nicegreen'>�� ���� ��� �������� �������� � ������������.</span>\n"
	mood_change = 1

/datum/mood_event/goodmusic
	description = "<span class='nicegreen'>� ���� ������ ���� ���-�� �������������.</span>\n"
	mood_change = 3
	timeout = 60 SECONDS

/datum/mood_event/chemical_euphoria
	description = "<span class='nicegreen'>���... ������... ����...</span>\n"
	mood_change = 4

/datum/mood_event/chemical_laughter
	description = "<span class='nicegreen'>Laughter ����� ������ ��������, �� ��� ��?!</span>\n"
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/chemical_superlaughter
	description = "<span class='nicegreen'>*����*</span>\n"
	mood_change = 12
	timeout = 3 MINUTES

/datum/mood_event/religiously_comforted
	description = "<span class='nicegreen'>��� ������� ��������� ����� �� ��������� ���������.</span>\n"
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/clownshoes
	description = "<span class='nicegreen'>��� ����� - �������� ��������, � �� ���� �� �������!</span>\n"
	mood_change = 5

/datum/mood_event/sacrifice_good
	description ="<span class='nicegreen'>���� �������� ���� �����������!</span>\n"
	mood_change = 5
	timeout = 3 MINUTES

/datum/mood_event/artok
	description = "<span class='nicegreen'>��� �������, ��� ����� ���������� ����������.</span>\n"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/artgood
	description = "<span class='nicegreen'>����� ������������ ���������� ������������ ���������, � �� ���� ��������� ������ � ��!</span>\n"
	mood_change = 4
	timeout = 5 MINUTES

/datum/mood_event/artgreat
	description = "<span class='nicegreen'>��� ������������ ��������� ����� ����������! � ����� ���� � ������� ������������, ����� ������ ������� � �����, ��� ������ ����� � ���� �����.</span>\n"
	mood_change = 6
	timeout = 5 MINUTES

/datum/mood_event/pet_borg
	description = "<span class='nicegreen'>I just love my robotical friends!</span>\n"
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/area
	description = "" //Fill this out in the area
	mood_change = 0

/datum/mood_event/area/add_effects(_mood_change, _description)
	mood_change = _mood_change
	description = _description
