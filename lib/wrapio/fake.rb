module WrapIO
	
	##
	# Enables faking of input to STDIN

	class Fake

		##
		# Used interally to store the given input data

		@data = nil

		##
		# @note Do not create instances of the +WrapIO::Fake+ class. Instead call +WrapIO::Fake#input+ to fake input to STDIN
		# @param input [String, Array<String>] the input

		def initialize(input)
			@data = input
			@length = input.length
		end

		##
		# Provides a proxy for +STDIN#gets+.
		# When the instance of +$stdin+ is swapped in +WrapIO::Fake#input+
		# this method with be called instead of the usual +STDIN#gets+.
		# Allowing injection of faked input.
		#
		# This function destructively iterates through the +@data+
		# array injecting the next value into +$stdin+. Once all indexes
		# in the given data are sent to +$stdin+, all subsequent calls to +gets+
		# will receive an empty string.

		def gets
			next_input = @data.shift
			index = @length - @data.length
			WrapIO.log(next_input, :input, index) if WrapIO.debug
			next_input.to_s
		end

		##
		# This is the main action of the +WrapIO::Fake+ class.
		# It passes the given input to +$stdin+.
		# Pass a single string or an array of strings to it and
		# each time +gets+ is called, a string from that array with be passed
		# to +$stdin+ starting from index 0 and moving to the end.
		#
		# @param value [String, Array<String>] the value of the faked input(s)
		# @yield the block of code to which you want to pass the given input(s)

		def self.input(value=nil)
			value = [value] unless value.is_a?(Array)
			begin
				$stdin = new(value)
				yield
			ensure
				$stdin = STDIN
			end
		end
	end
end