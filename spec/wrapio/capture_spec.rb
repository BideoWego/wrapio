require 'spec_helper'

describe WrapIO::Capture do
	describe '#output' do
		it 'captures output from stdout' do
			@output = WrapIO::Capture.output do
				print "Hi!"
			end
			expect(@output).to eq("Hi!")
		end
	end
end
