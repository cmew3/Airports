require 'weather'
require 'mocha'

shared_examples 'a weather region' do
	
	let (:location) { described_class.new }

	it 'returns stormy weather when number generated is 0' do
		expect(Kernel).to receive(:rand).with(10).and_return(0)
		location.check_weather
		expect(location).to be_stormy
	end

	it 'returns stormy weather when number generated is 1' do
		expect(Kernel).to receive(:rand).with(10).and_return(1)
		location.check_weather
		expect(location).not_to be_stormy
	end

end				