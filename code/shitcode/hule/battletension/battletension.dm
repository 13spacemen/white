//�������� �������� �� ������������

#define BATTLE_MUSIC_PATH 	"code/shitcode/hule/battletension/bm/"
#define BATTLE_MUSIC_LIST 	list("80sspark.ogg","badapple.ogg")

#define CHANNEL_BATTLE 		1015

PROCESSING_SUBSYSTEM_DEF(btension)
	name = "Battle Tension"
	priority = 15
	flags = SS_NO_INIT
	wait = 10

/mob/living
	var/datum/btension/battletension

//nasral na living_defense.dm & item_attack.dm & carbon_defense.dm

/mob/living/proc/create_tension(var/amount)
	if(mind && !battletension)
		battletension = new /datum/btension
		battletension.owner = src

	if(battletension.tension)
		battletension.tension += amount
	else
		battletension.tension = amount

/datum/btension
	var/mob/living/owner
	var/tension = 0
	var/sound/bm

/datum/btension/New()
	. = ..()
	START_PROCESSING(SSbtension, src)

/datum/btension/Destroy()
	if(bm)
		qdel(bm)
	STOP_PROCESSING(SSbtension, src)
	. = ..()

/datum/btension/proc/get_sound_list()
	var/list/bmlist = list()
	for(var/I in BATTLE_MUSIC_LIST)
		bmlist += BATTLE_MUSIC_PATH + I
	return bmlist

/datum/btension/process()
	if(!bm && tension > 0)
		var/sound/S = sound(pick(get_sound_list()))
		if(!S || !S.file)
			return
		S.repeat = 1
		S.channel = CHANNEL_BATTLE
		S.falloff = 2
		S.wait = 0
		S.volume = 0
		S.status = SOUND_STREAM
		//S.environment = 0 //�� ��� ����� � ����� ����
		bm = S
		SEND_SOUND(owner, bm)
		bm.status = SOUND_STREAM

	if(!bm || !bm.file)
		return

	switch(tension)
		if(-INFINITY to -1)
			bm.volume = 0
			SEND_SOUND(owner, bm)
			bm.status = SOUND_UPDATE
		if(0 to 30)
			bm.volume = tension
			SEND_SOUND(owner, bm)
			bm.status = SOUND_UPDATE
			tension -= 1
		if(31 to 79)
			bm.volume = tension
			SEND_SOUND(owner, bm)
			bm.status = SOUND_UPDATE
		/*	var/i
			for (i = 0, i < 10, i++)
				battle_screen_on()
				sleep(1)
				set_blurriness(0)
				sleep(1)*/
		if(80 to INFINITY)
			tension = 80
			bm.volume = 80
			SEND_SOUND(owner, bm)
			bm.status = SOUND_UPDATE

	if (tension > 0)
		tension -= 2
	else
		bm = null