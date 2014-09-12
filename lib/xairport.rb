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

	def clear_for_landing plane
		dock plane if landing_checks_completed?(plane)
	end	

	def landing_checks_completed? (plane)
		return puts "Plane is already grounded" unless plane.flying?
		return  puts "Cannot land due to inclement weather" if stormy?
		return puts "No space available at the airport" if self.full?
		true
	end

	def dock plane
		puts "Plane has landed"

		# plane.land
		(@planes << plane.land).last
		# puts "Plane has landed"
	end

	def clear_for_take_off plane
		release plane if take_off_checks_completed?(plane)
	end
	
	def take_off_checks_completed? plane
		return puts "That plane isn't at this airport" unless planes.include?(plane)
		return puts "Cannot take-off due to inclement weather" if stormy?
		true
	end	

	def release plane
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

	def keep_requesting_land plane
		while plane.flying?
			self.clear_for_landing(plane)
		end
	end


	def dock_all planes
		planes.each do |plane|
			keep_requesting_land(plane)
		end
	end

	def keep_requesting_take_off plane
			while plane.flying? == false
				clear_for_take_off(plane)
			end
		end

	def release_all_planes	
		while plane_count > 0
			keep_requesting_take_off planes.last
		end 
	end

end