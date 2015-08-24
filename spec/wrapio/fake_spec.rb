require 'spec_helper'

describe WrapIO::Fake do
	describe '#input' do
		it 'fakes input to stdin' do
			WrapIO::Fake.input('Hello!') do
				@input = $stdin.gets
			end
			expect(@input).to eq('Hello!')
		end
	end
end

