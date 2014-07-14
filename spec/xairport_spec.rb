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

	context 'when docking and releasing planes' do
	
		it 'can dock a plane' do
			allow(STDOUT).to receive(:puts).and_return nil	
			airport.dock(flying_plane)
			expect(airport.planes).to eq [flying_plane]
		end

		it 'a plane lands when the airport docks it' do
			allow(STDOUT).to receive(:puts).and_return nil
			test_plane = double :plane
			expect(test_plane).to receive(:land)
			airport.dock(test_plane)
		end

		it 'can release plane' do
			allow(STDOUT).to receive(:puts).and_return nil
			airport_with_plane.release(grounded_plane)
			expect(airport_with_plane.planes).to eq []
		end

		it 'a plane takes off when launched' do
			allow(STDOUT).to receive(:puts).and_return nil
			test_plane = double :plane
			expect(test_plane).to receive(:take_off)
			airport_with_plane.release(test_plane)
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
			allow(STDOUT).to receive(:puts).and_return nil
			allow(airport).to receive(:stormy?).and_return(false)
			airport.clear_for_landing(flying_plane)
			expect(airport.plane_count).to eq 1
		end

		it 'knows when it is full' do
			allow(STDOUT).to receive(:puts).and_return nil
			allow(airport).to receive(:stormy?).and_return(false)
			Airport::DEFAULT_CAPACITY.times {airport.clear_for_landing(flying_plane)}
			expect(airport).to be_full
		end

	end

	context 'weather' do

		it_behaves_like 'a weather region'

		it 'is not stormy when created' do
			expect(airport).not_to be_stormy
		end

	end

	context 'traffic control' do

		it 'only clears a plane for landing if it is flying' do
			allow(STDOUT).to receive(:puts).and_return nil
			allow(airport).to receive(:stormy?).and_return(false)
			
			airport.clear_for_landing(grounded_plane)
			expect(airport.plane_count).to eq 0	
		end

		it 'does not clear a plane for take off which is not there' do
			plane = double :plane
			allow(STDOUT).to receive(:puts).and_return nil
			allow(airport).to receive(:stormy?).and_return(true)

			expect(plane).not_to receive(:take_off)
			airport.clear_for_take_off(plane)
		end

		it 'does not clear for landing a plane when it is full' do
			allow(STDOUT).to receive(:puts).and_return nil
			allow(airport).to receive(:stormy?).and_return(false)
			Airport::DEFAULT_CAPACITY.times {airport.clear_for_landing(flying_plane)}
			
			airport.clear_for_landing(flying_plane_2)
			expect(airport.plane_count).to eq Airport::DEFAULT_CAPACITY
		end

		it 'does not land a plane when it is full' do
			allow(STDOUT).to receive(:puts).and_return nil
			allow(airport).to receive(:stormy?).and_return(false)
			Airport::DEFAULT_CAPACITY.times {airport.clear_for_landing(flying_plane)}
			
			expect(flying_plane_2).not_to receive(:land)
			airport.clear_for_landing(flying_plane_2)
		end


		it 'does not clear for landing a plane when it is stormy' do
			allow(STDOUT).to receive(:puts).and_return nil
			allow(airport).to receive(:stormy?).and_return(true)

			airport.clear_for_landing(flying_plane)
			expect(airport.plane_count).to eq 0
		end

		it 'plane does not land if it is stormy' do
			allow(STDOUT).to receive(:puts).and_return nil
			allow(airport).to receive(:stormy?).and_return(true)
			
			expect(flying_plane).not_to receive(:land)
			airport.clear_for_landing(flying_plane)
		end

		it 'does not clear for take off a plane when it is stormy' do
			allow(STDOUT).to receive(:puts).and_return nil
			allow(airport_with_plane).to receive(:stormy?).and_return(true)
			
			airport_with_plane.clear_for_take_off(grounded_plane)
			expect(airport_with_plane.plane_count).to eq 1
		end

		it 'a plane does not take off when it is stormy' do
			allow(STDOUT).to receive(:puts).and_return nil
			allow(airport_with_plane).to receive(:stormy?).and_return(true)
			
			expect(grounded_plane).not_to receive(:take_off)
			airport_with_plane.clear_for_take_off(grounded_plane)
		end

	end

	context 'the grand finale' do
		# Do not use doubles here as this feels more like an integration test.


		 it 'six planes can land' do
		 	planes = []
		 	6.times {planes << Plane.new}
		 	allow(STDOUT).to receive(:puts).and_return nil
			airport.dock_all(planes)
		 	
		 	expect(airport.plane_count).to eq 6
	  	end

		 it 'all planes are grounded when they have landed' do
		 	planes = []
		 	6.times {planes << Plane.new}
		 	allow(STDOUT).to receive(:puts).and_return nil
			airport.dock_all(planes)

		 	airport.planes.each do |plane|
		 		expect(plane).not_to be_flying
		 	end
		 end

		 it 'releases all planes' do
		 	plane_list = []
		 	6.times {plane_list << Plane.new}
		 	allow(STDOUT).to receive(:puts).and_return nil
			airport.dock_all(plane_list)

			airport.release_all_planes
		 	expect(airport.plane_count).to eq 0
		end	

		it 'all planes are flying when they are released' do
			plane_list = []
		 	6.times {plane_list << Plane.new}
		 	allow(STDOUT).to receive(:puts).and_return nil
			airport.dock_all(plane_list)

			airport.release_all_planes
		 	plane_list.each do |plane|
		 		expect(plane).to be_flying
		 	end
		end

  	end

end			