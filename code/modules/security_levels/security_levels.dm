//SEC_LEVEL_GREEN = code green
//SEC_LEVEL_BLUE = code blue
//SEC_LEVEL_RED = code red
//SEC_LEVEL_DELTA = code delta

//config.alert_desc_blue_downto

/proc/set_security_level(level)
	switch(level)
		if("green")
			level = SEC_LEVEL_GREEN
		if("blue")
			level = SEC_LEVEL_BLUE
		if("red")
			level = SEC_LEVEL_RED
		if("delta")
			level = SEC_LEVEL_DELTA

	//Will not be announced if you try to set to the same level as it already is
	if(level >= SEC_LEVEL_GREEN && level <= SEC_LEVEL_DELTA && level != SSsecurity_level.current_level)
		switch(level)
			if(SEC_LEVEL_GREEN)
				minor_announce(CONFIG_GET(string/alert_green), "Внимание! Уровень безопасности понижен до зелёного.")
				if(SSshuttle.emergency.mode == SHUTTLE_CALL || SSshuttle.emergency.mode == SHUTTLE_RECALL)
					if(SSsecurity_level.current_level >= SEC_LEVEL_RED)
						SSshuttle.emergency.modTimer(4)
					else
						SSshuttle.emergency.modTimer(2)
			if(SEC_LEVEL_BLUE)
				if(SSsecurity_level.current_level < SEC_LEVEL_BLUE)
					minor_announce(CONFIG_GET(string/alert_blue_upto), "Внимание! Уровень безопасности повышен до синего.",1)
					if(SSshuttle.emergency.mode == SHUTTLE_CALL || SSshuttle.emergency.mode == SHUTTLE_RECALL)
						SSshuttle.emergency.modTimer(0.5)
				else
					minor_announce(CONFIG_GET(string/alert_blue_downto), "Внимание! Уровень безопасности понижен до синего.")
					if(SSshuttle.emergency.mode == SHUTTLE_CALL || SSshuttle.emergency.mode == SHUTTLE_RECALL)
						SSshuttle.emergency.modTimer(2)
			if(SEC_LEVEL_RED)
				if(SSsecurity_level.current_level < SEC_LEVEL_RED)
					minor_announce(CONFIG_GET(string/alert_red_upto), "Внимание! Красный код!",1)
					if(SSshuttle.emergency.mode == SHUTTLE_CALL || SSshuttle.emergency.mode == SHUTTLE_RECALL)
						if(SSsecurity_level.current_level == SEC_LEVEL_GREEN)
							SSshuttle.emergency.modTimer(0.25)
						else
							SSshuttle.emergency.modTimer(0.5)
				else
					minor_announce(CONFIG_GET(string/alert_red_downto), "Внимание! Красный код!")
			if(SEC_LEVEL_DELTA)
				minor_announce(CONFIG_GET(string/alert_delta), "Внимание! Код Дельта!",1)
				if(SSshuttle.emergency.mode == SHUTTLE_CALL || SSshuttle.emergency.mode == SHUTTLE_RECALL)
					if(SSsecurity_level.current_level == SEC_LEVEL_GREEN)
						SSshuttle.emergency.modTimer(0.25)
					else if(SSsecurity_level.current_level == SEC_LEVEL_BLUE)
						SSshuttle.emergency.modTimer(0.5)

		SSsecurity_level.set_level(level)

/proc/get_security_level()
	switch(SSsecurity_level.current_level)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/num2seclevel(num)
	switch(num)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/seclevel2num(seclevel)
	switch( lowertext(seclevel) )
		if("green")
			return SEC_LEVEL_GREEN
		if("blue")
			return SEC_LEVEL_BLUE
		if("red")
			return SEC_LEVEL_RED
		if("delta")
			return SEC_LEVEL_DELTA
