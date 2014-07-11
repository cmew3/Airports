class Airport

	DEFAULT_CAPACITY = 6

	def initialize (capacity: DEFAULT_CAPACITY)
		@capacity = capacity
		@planes ||= []
	end

	def planes
		@planes	
	end

	def accept plane
		unless self.full?
			plane.land
			@planes << plane
		end
	end


	def release plane
		raise "That plane isn't at this airport" unless planes.include?(plane)
		plane.take_off
		@planes.delete(plane)

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