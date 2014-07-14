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

	# def accept plane
	# 	self.check_weather
	# 	if plane.flying?
	# 		unless stormy?
	# 			unless self.full?
	# 				plane.land
	# 				@planes << plane
	# 			end
	# 		end
	# 	end
	# end	

	def accept plane
		return puts "Plane is already grounded" unless plane.flying?
		self.check_weather
		return  puts "Cannot land due to inclement weather" if stormy?
		return puts "No space available at the airport" if self.full?
		plane.land
		@planes << plane
		puts "Plane has landed"
	end	


	def release plane
		return puts "That plane isn't at this airport" unless planes.include?(plane)
		self.check_weather
		return puts "Cannot take-off due to inclement weather" if stormy?
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