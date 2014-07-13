module WeatherRegion

	def stormy?
		@stormy ||= false
	end

	def check_weather
		random_weather_generator = Kernel.rand(10)	
		if random_weather_generator == 0
			@stormy = true
		else
			@stormy = false
		end
	end
end