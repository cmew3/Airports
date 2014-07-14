require 'xairport'


describe Airport do

	let (:airport)  			{ Airport.new 												}
	let (:flying_plane)			{ double :plane, land: nil, take_off: nil, flying?: true 	}
	let (:flying_plane_2)		{ double :plane, land: nil, take_off: nil, flying?: true  	}
	let (:grounded_plane)		{ double :plane, land: nil, take_off: nil, flying?: false 	}
	let (:airport_with_plane) 	{ Airport.new(planes: [grounded_plane])						}

	it 'has no planes when created' do
		expect(airport.planes).to eq []
	end

	context 'when clear_for_landinging and releasing planes' do
	
		it 'can land a plane' do
			airport.land(flying_plane)
			expect(airport.planes).to eq [flying_plane]
		end

		it 'lands a plane when it lands it' do
			test_plane = double :plane, flying?: true
			expect(test_plane).to receive(:land)
			airport.land(test_plane)
		end

		it 'only clears a plane for takeoff which is flying' do
			allow(airport).to receive(:stormy?).and_return(false)
			plane = double :plane, flying?: false, land: nil
			airport.clear_for_landing(plane)
			expect(airport.plane_count).to eq 0	
		end

		it 'can clear a plane for take-off' do
			allow(airport_with_plane).to receive(:stormy?).and_return(false)
			airport_with_plane.clear_for_take_off(grounded_plane)
			expect(airport_with_plane.planes).to eq []
		end

		it 'a plane takes off when cleared for take off' do
			allow(airport_with_plane).to receive(:stormy?).and_return(false)
			expect(grounded_plane).to receive(:take_off)
			airport_with_plane.clear_for_take_off(grounded_plane)
		end

		it 'does not clear a plane for take off which is not there' do
			plane = double :plane
			allow(airport).to receive(:stormy?).and_return(true)
			airport.clear_for_take_off(plane)
			expect(plane).not_to receive(:take_off)
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
			allow(airport).to receive(:stormy?).and_return(false)
			airport.clear_for_landing(flying_plane)
			expect(airport.plane_count).to eq 1
		end

		it 'knows when it is full' do
			allow(airport).to receive(:stormy?).and_return(false)
			Airport::DEFAULT_CAPACITY.times {airport.clear_for_landing(flying_plane)}
			expect(airport).to be_full
		end

	end

	context 'weather' do

		it_behaves_like 'a weather region'

		it 'it not stormy when created' do
			expect(airport).not_to be_stormy
		end

	end

	context 'traffic control' do



		it 'does not clear for landing a plane when it is full' do
			allow(airport).to receive(:stormy?).and_return(false)
			Airport::DEFAULT_CAPACITY.times {airport.clear_for_landing(flying_plane)}
			airport.clear_for_landing(flying_plane_2)
			expect(airport.plane_count).to eq Airport::DEFAULT_CAPACITY
		end

		it 'does not land a plane when it is full' do
			allow(airport).to receive(:stormy?).and_return(false)
			Airport::DEFAULT_CAPACITY.times {airport.clear_for_landing(flying_plane)}
			expect(flying_plane_2).not_to receive(:land)
			airport.clear_for_landing(flying_plane_2)
		end


		it 'does not clear for landing a plane when it is stormy' do
			allow(airport).to receive(:stormy?).and_return(true)
			airport.clear_for_landing(flying_plane)
			expect(airport.plane_count).to eq 0
		end

		it 'does not land a plane when it is stormy' do
			allow(airport).to receive(:stormy?).and_return(true)
			expect(flying_plane).not_to receive(:land)
			airport.clear_for_landing(flying_plane)
		end

		it 'does not clear for take off a plane when it is stormy' do
			airport = Airport.new(planes: [grounded_plane])
			allow(airport).to receive(:stormy?).and_return(true)
			airport.clear_for_take_off(grounded_plane)
			expect(airport.plane_count).to eq 1
		end

		it 'a plane does not take of when it is stormy' do
			airport = Airport.new(planes: [grounded_plane])
			allow(airport).to receive(:stormy?).and_return(true)
			
			expect(grounded_plane).not_to receive(:take_off)
			airport.clear_for_take_off(grounded_plane)
		end

	end

end			