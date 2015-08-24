require 'spec_helper'

describe WrapIO do
	it 'has a version number' do
		expect(WrapIO::VERSION).not_to be nil
	end

	describe '#of' do
		it 'captures the output of STDOUT' do
			@output = WrapIO.of do
				print "Hello World!"
			end
			expect(@output).to eq("Hello World!")
		end

		it 'fakes the input of STDIN' do
			WrapIO.of('') do
				expect($stdin).to receive(:gets)
				$stdin.gets
			end
		end

		it 'logs the input and output when debug is enabled' do
			WrapIO.debug = true
			@output = WrapIO.of('input') do
				$stdin.gets
				puts 'output'
			end
			expect(@output).to eq("-- WrapIO Fake#gets 1 --\ninput\n________________________\noutput\n")
		end
	end
end
