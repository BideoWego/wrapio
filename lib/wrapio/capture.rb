##

module WrapIO
	class Capture

		##

		def self.output
			begin
				$stdout = captor = StringIO.new
				yield($stdout)
			ensure
				$stdout = STDOUT
			end
			WrapIO.log(captor.string, :output) if WrapIO.debug
			captor.string
		end
	end
end