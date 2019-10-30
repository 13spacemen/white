/datum/mood_event/handcuffed
	description = "<span class='warning'>������� ��� ������� ���-�� �������.</span>\n"
	mood_change = -1

/datum/mood_event/broken_vow //Used for when mimes break their vow of silence
  description = "<span class='boldwarning'>�� ��� ���� ��������� ���������� ����� �����...</span>\n"
  mood_change = -8

/datum/mood_event/on_fire
	description = "<span class='boldwarning'>� ����!!!/span>\n"
	mood_change = -12

/datum/mood_event/suffocation
	description = "<span class='boldwarning'>��.. ����... ������...</span>\n"
	mood_change = -12

/datum/mood_event/burnt_thumb
	description = "<span class='warning'>�� ������ ��� ������ � ����������.</span>\n"
	mood_change = -1
	timeout = 2 MINUTES

/datum/mood_event/cold
	description = "<span class='warning'>��� ����� �������.</span>\n"
	mood_change = -5

/datum/mood_event/hot
	description = "<span class='warning'>���������� ���������.</span>\n"
	mood_change = -5

/datum/mood_event/creampie
	description = "<span class='warning'>���� ��������. �� ���� ��� �����.</span>\n"
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/slipped
	description = "<span class='warning'>����� ���������������. ���� ���� ����������.</span>\n"
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/eye_stab
	description = "<span class='boldwarning'>I used to be an adventurer like you, until I took a screwdriver to the eye.</span>\n"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/delam //SM delamination
	description = "<span class='boldwarning'>��� �������� ������� �� ����� ���-�� ������� ���������...</span>\n"
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/depression
	description = "<span class='warning'>��� ������� ��� �����-���� ������.</span>\n"
	mood_change = -12
	timeout = 2 MINUTES

/datum/mood_event/shameful_suicide //suicide_acts that return SHAME, like sord
  description = "<span class='boldwarning'>� ���� �� ���� ��������� �� ���� ����!</span>\n"
  mood_change = -15
  timeout = 60 SECONDS

/datum/mood_event/dismembered
  description = "<span class='boldwarning'>��-�! ��� ����� ���� ��� ����������!</span>\n"
  mood_change = -10
  timeout = 8 MINUTES

/datum/mood_event/tased
	description = "<span class='warning'>There's no \"z\" in \"taser\". It's in the zap.</span>\n"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/embedded
	description = "<span class='boldwarning'>��������� ��� �� ����, ���������!</span>\n"
	mood_change = -7

/datum/mood_event/table
	description = "<span class='warning'>���-�� ������ ���� �� ����!</span>\n"
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/table/add_effects()
	if(isfelinid(owner))
		var/mob/living/carbon/human/H = owner
		H.dna.species.start_wagging_tail(H)
		addtimer(CALLBACK(H.dna.species, /datum/species.proc/stop_wagging_tail, H), 30)
		description =  "<span class='nicegreen'>�� ���� ����� ���������� �� �����!</span>\n"
		mood_change = 2

/datum/mood_event/table_headsmash
	description = "<span class='warning'>My fucking head, that hurt...</span>"
	mood_change = -3
	timeout = 3 MINUTES

/datum/mood_event/brain_damage
  mood_change = -3

/datum/mood_event/brain_damage/add_effects()
  var/damage_message = pick_list_replacements(BRAIN_DAMAGE_FILE, "brain_damage")
  description = "<span class='warning'>���... ���... [damage_message]</span>\n"

/datum/mood_event/hulk //Entire duration of having the hulk mutation
  description = "<span class='warning'>���� ����!</span>\n"
  mood_change = -4

/datum/mood_event/epilepsy //Only when the mutation causes a seizure
  description = "<span class='warning'>������ �������� �������� �� �������������� �� ���������.</span>\n"
  mood_change = -3
  timeout = 5 MINUTES

/datum/mood_event/nyctophobia
	description = "<span class='warning'>����� ���������...</span>\n"
	mood_change = -3

/datum/mood_event/family_heirloom_missing
	description = "<span class='warning'>� ������ �� ���� �������� ��������...</span>\n"
	mood_change = -4

/datum/mood_event/healsbadman
	description = "<span class='warning'>���� ������ ������ ����, � � ���� ��������, ��� � ���� ����������� � ����� ������!</span>\n"
	mood_change = -4
	timeout = 2 MINUTES

/datum/mood_event/jittery
	description = "<span class='warning'>� ���������, ��������� � �� ���� ������ �����!</span>\n"
	mood_change = -2

/datum/mood_event/vomit
	description = "<span class='warning'>���� ������ ��� �������. ��������.</span>\n"
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/vomitself
	description = "<span class='warning'>���� ������ ��� �������� �� ����. ��� �������������.</span>\n"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/painful_medicine
	description = "<span class='warning'>�������� ����� ���� � ������ ��� ����, �� ������ ��� ����� �����!</span>\n"
	mood_change = -5
	timeout = 60 SECONDS

/datum/mood_event/spooked
	description = "<span class='warning'>����������� ��� ������... � �� ���� ��� ������.</span>\n"
	mood_change = -4
	timeout = 4 MINUTES

/datum/mood_event/loud_gong
	description = "<span class='warning'>���� ���� � ������ ����� ������!</span>\n"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/notcreeping
	description = "<span class='warning'>������ �� ���� ����, ��� � �� �������� ��� �������, � ��� ���������� ���������� ��� ����� ��������� ���.</span>\n"
	mood_change = -6
	timeout = 30
	hidden = TRUE

/datum/mood_event/notcreepingsevere//not hidden since it's so severe
	description = "<span class='boldwarning'>����� ������� �����!!</span>\n"
	mood_change = -30
	timeout = 30

/datum/mood_event/notcreepingsevere/add_effects(name)
	var/list/unstable = list(name)
	for(var/i in 1 to rand(3,5))
		unstable += copytext(name, -1)
	var/unhinged = uppertext(unstable.Join(""))//example Tinea Luxor > TINEA LUXORRRR (with randomness in how long that slur is)
	description = "<span class='boldwarning'>����� ������� [unhinged]!!</span>\n"

/datum/mood_event/sapped
	description = "<span class='boldwarning'>������������ ������ �������� ����...</span>\n"
	mood_change = -15
	timeout = 90 SECONDS

/datum/mood_event/back_pain
	description = "<span class='boldwarning'>����� ������� �� ����� ����� �� ���� �����, ��� ����� ������!</span>\n"
	mood_change = -15

/datum/mood_event/sad_empath
	description = "<span class='warning'>���-�� ������ �������...</span>\n"
	mood_change = -2
	timeout = 60 SECONDS

/datum/mood_event/sad_empath/add_effects(mob/sadtarget)
	description = "<span class='warning'>[sadtarget.name] ������� �������...</span>\n"

/datum/mood_event/sacrifice_bad
	description ="<span class='warning'>��� ������� ������!</span>\n"
	mood_change = -5
	timeout = 2 MINUTES

/datum/mood_event/artbad
	description = "<span class='warning'>� ���� ���������� � ����� ��� ���.</span>\n"
	mood_change = -2
	timeout = 1200

/datum/mood_event/graverobbing
	description ="<span class='boldwarning'>I just desecrated someone's grave... I can't believe I did that...</span>\n"
	mood_change = -8
	timeout = 3 MINUTES

//These are unused so far but I want to remember them to use them later
/datum/mood_event/cloned_corpse
	description = "<span class='boldwarning'>���... �����������... ����...</span>\n"
	mood_change = -6

/datum/mood_event/surgery
	description = "<span class='boldwarning'>���� ����� �� �������!!</span>\n"
	mood_change = -8

/datum/mood_event/nanite_sadness
	description = "<span class='warning robot'>+++++++HAPPINESS SUPPRESSION+++++++</span>\n"
	mood_change = -7

/datum/mood_event/nanite_sadness/add_effects(message)
	description = "<span class='warning robot'>+++++++[message]+++++++</span>\n"

