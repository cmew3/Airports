class Airport

	DEFAULT_CAPACITY = 6

	def initialize (capacity: DEFAULT_CAPACITY)
		@capacity = capacity
		@planes ||= []
	end

	def planes
		@planes	
	end

	def land plane
		@planes << plane
	end

	def release plane
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