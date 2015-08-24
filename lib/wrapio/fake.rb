module WrapIO
	##

	class Fake

		##

		@@data = nil

		def initialize(input)
			@@data = input
			@@length = input.length
		end

		##

		def gets
			next_input = @@data.shift
			index = @@length - @@data.length
			WrapIO.log(next_input, :input, index) if WrapIO.debug
			next_input.to_s
		end

		##

		def self.input(value=nil)
			value = [value] unless value.is_a?(Array)
			begin
				$stdin = new(value)
				yield($stdin)
			ensure
				$stdin = STDIN
			end
		end
	end
end