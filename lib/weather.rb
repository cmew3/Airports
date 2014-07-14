module WeatherRegion

	STORM_PROBABILITY_DENOMINATOR = 10
	
	def stormy?
		@stormy ||= false
	end

	def check_weather
		random_weather_generator = Kernel.rand(STORM_PROBABILITY_DENOMINATOR)	
		if random_weather_generator == 0
			@stormy = true
		else
			@stormy = false
		end
	end
end