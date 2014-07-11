require 'airport'

describe Airport do

	let (:airport)  { Airport.new }
	let (:plane)	{ double  }

	it 'has no planes when created' do
		expect(airport.planes).to eq []
	end

	it 'can land a plane' do
		airport.land(plane)
		expect(airport.planes).to eq [plane]
	end

	it 'can release a plane' do
		airport.land(plane)
		airport.release(plane)
		expect(airport.planes).to eq []
	end

	it 'knows its capacity' do
		expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
	end

	it 'can be created with a capacity of 100' do
		airport = Airport.new(capacity: 100)
		expect(airport.capacity).to eq 100
	end

	it 'knows how many planes it has' do
		airport.land(plane)
		expect(airport.plane_count).to eq 1
	end

	it 'knows when it is full' do
		Airport::DEFAULT_CAPACITY.times {airport.land(plane)}
		expect(airport).to be_full
	end


end			