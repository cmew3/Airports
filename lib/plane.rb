class Plane

	def initialize
		@flying = true
	end

	def flying?
		@flying
	end

	def land
		@flying = false
		self
	end

	def take_off
		@flying = true
		self
	end

end