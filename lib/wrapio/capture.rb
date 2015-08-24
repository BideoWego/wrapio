module WrapIO

	##
	# A small class built to capture the output from STDOUT.

	class Capture

		##
		# Captures the output of +$stdout+.
		# Temporarily swaps +$stdout+ with an instance of the +StringIO+ class.
		# 
		# @yield the block of code from which to capture output

		def self.output
			begin
				$stdout = captor = StringIO.new
				yield
			ensure
				$stdout = STDOUT
			end
			WrapIO.log(captor.string, :output) if WrapIO.debug
			captor.string
		end
	end
end