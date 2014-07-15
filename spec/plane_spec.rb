require 'plane'

describe Plane do
		
	let (:plane) { Plane.new }

	it 'is flying when created' do
		expect(plane).to be_flying
	end

	it 'can land' do
		plane.land
		expect(plane).not_to be_flying
	end

	it 'can take off' do
		plane.land
		plane.take_off
		expect(plane).to be_flying
	end

end