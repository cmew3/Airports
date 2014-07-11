class Plane

	def initialize
		@flying = true
	end

	# attribute getter
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