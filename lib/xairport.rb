class Airport

include WeatherRegion

	DEFAULT_CAPACITY = 6

	def initialize (capacity: DEFAULT_CAPACITY, planes: [])
		@capacity = capacity
		@planes = planes
	end

	def DEFAULT_CAPACITY
		@capacity
	end

	def planes
		@planes	||= []
	end

	def landing_checks_completed? (plane)
		return puts "Plane is already grounded" unless plane.flying?
		self.check_weather
		return  puts "Cannot land due to inclement weather" if stormy?
		return puts "No space available at the airport" if self.full?
		true
	end

	def clear_for_landing plane
		if landing_checks_completed? plane
		land plane
		end
	end	

	def land plane
		plane.land
		@planes << plane
		puts "Plane has landed"
	end

	
	def take_off_checks_completed? plane
		return puts "That plane isn't at this airport" unless planes.include?(plane)
		self.check_weather
		return puts "Cannot take-off due to inclement weather" if stormy?
		true
	end	

	def clear_for_take_off plane
		if take_off_checks_completed? plane
		launch plane
		end	
	end

	def launch plane
		plane.take_off
		@planes.delete(plane)
		puts "Plane has taken-off"
	end


	def capacity
		@capacity
	end

	def plane_count
		planes.count
	end
	
	def full?
		plane_count == capacity
	end

end