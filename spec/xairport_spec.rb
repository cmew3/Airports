require 'xairport'


describe Airport do

	let (:airport)  { Airport.new }
	let (:plane)	{ double :plane, land: nil, take_off: nil  }
	let (:another_plane)	{ double :plane, land: nil, take_off: nil  }

	it 'has no planes when created' do
		expect(airport.planes).to eq []
	end

	context 'when accepting and releasing planes' do
	
		it 'can accept a plane' do
			airport.accept(plane)
			expect(airport.planes).to eq [plane]
		end

		it 'lands a plane when it accepts it' do
			test_plane = double :plane
			expect(test_plane).to receive(:land)
			airport.accept(test_plane)
		end

		it 'can release a plane' do
			airport.accept(plane)
			airport.release(plane)
			expect(airport.planes).to eq []
		end

		it 'a plane takes off when released' do
			test_plane = double :plane, land: nil
			airport.accept(plane)		

			expect(plane).to receive(:take_off)
			airport.release(plane)
		end

	end	

	context 'regarding capcity' do

		it 'knows its capacity' do
			expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
		end

		it 'can be created with a capacity of 100' do
			airport = Airport.new(capacity: 100)
			expect(airport.capacity).to eq 100
		end

		it 'knows how many planes it has' do
			airport.accept(plane)
			expect(airport.plane_count).to eq 1
		end

		it 'knows when it is full' do
			Airport::DEFAULT_CAPACITY.times {airport.accept(plane)}
			expect(airport).to be_full
		end

	end

	context 'traffic control' do

		it 'does not accept a plane when it is full' do
			Airport::DEFAULT_CAPACITY.times {airport.accept(plane)}
			airport.accept(another_plane)
			expect(airport.plane_count).to eq Airport::DEFAULT_CAPACITY
		end

		it 'does not release a plane which is not there' do
			plane = double :plane
			expect { airport.release(plane) }.to raise_error(RuntimeError)
		end

	end

	context 'weather' do

		it_behaves_like 'a weather region'

		it 'it not stormy when created' do
			expect(airport).not_to be_stormy
		end

	end

end			