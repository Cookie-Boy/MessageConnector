%dw 2.0

fun calculateDuration(startTime: DateTime, endTime: DateTime): Number =
	((endTime - startTime).seconds * 1000) + (endTime.milliseconds - startTime.milliseconds)
	
fun changeLogLevel(value: Any, nameAttr: String, newLevel: String) = do {
   value match {
       case obj is Object -> obj mapObject ((value, key, index) ->
           if (key ~= "AsyncLogger" and key.@name ~= nameAttr)
               (key) @(name: nameAttr, level: newLevel): value
           else   
               (key) @((changeLogLevel(key.@, nameAttr, newLevel))): changeLogLevel(value, nameAttr, newLevel)
       )
       else -> value
   }
}

fun callIfLoggerEnoughLevel(callable, level: String = "DEBUG", loggerName: String = "org.mule.runtime.core.internal.processor.LoggerMessageProcessor", else_callable = () -> null) = 
	do {
		var loggerLevel = getLoggerLevel(loggerName)
		---
		if (loggerLevel != null and loggerLevel.intLevel >= loggerLevel[level].intLevel)
			callable()
		else
			else_callable()
	}

fun getLoggerLevel(loggerName: String = "org.mule.runtime.core.internal.processor.LoggerMessageProcessor"): String | Null = 
	java!org::apache::logging::log4j::LogManager::getContext(false).configuration
																   .loggerConfigs[loggerName]
																   .level