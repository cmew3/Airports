module WeatherRegion

	STORM_PROBABILITY_DENOMINATOR = 10
	
	def stormy?
		Kernel.rand(STORM_PROBABILITY_DENOMINATOR) == 0
	end

	# def check_weather
	# 	# random_weather_generator = Kernel.rand(STORM_PROBABILITY_DENOMINATOR)	
	# 	# if random_weather_generator == 0
	# 	# 	@stormy = true
	# 	# else
	# 	# 	@stormy = false
	# 	stormy?
	# end
end