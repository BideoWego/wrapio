require_relative 'wrapio/version.rb'
require_relative 'wrapio/capture.rb'
require_relative 'wrapio/fake.rb'

##

module WrapIO

	##

	@@debug = false

	##

	@@delimiters = {
		:input => 'Fake#gets',
		:output => 'Capture#output'
	} 

	##

	@@default_input = ''

	##

	def self.debug
		@@debug
	end

	##

	def self.debug=(value)
		@@debug = value
	end

	##

	def self.default_input
		@@default_input
	end

	##

	def self.default_input=(value)
		@@default_input = value
	end

	##

	def self.of(value=nil)
		value = WrapIO.default_input unless value
		Capture.output do |stdout|
			Fake.input(value) do |stdin|
				yield(stdin, stdout)
			end
		end
	end

	##

	def self.log(data, type, index=nil)
		puts delimit(data, type, index.to_s)
	end

	private
		def self.delimit(string, type, index)
			delimitation = "-- WrapIO %T% %I% --"
			b = delimitation.gsub(/%T%/, @@delimiters[type]).gsub(/%I%/, index)
			c = string
			e = '_' * b.length
			[b, c, e].join("\n")
		end
end
