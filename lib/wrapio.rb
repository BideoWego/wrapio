require_relative 'wrapio/version.rb'
require_relative 'wrapio/capture.rb'
require_relative 'wrapio/fake.rb'

##
# A small module that allows performs both
# capturing output from STDOUT
# and faking input to STDIN.

module WrapIO

	##
	# @!attribute debug
	# @return [Boolean] +true+ if debugging is enabled

	@@debug = false

	##
	# Internal markers for debug logging

	@@delimiters = {
		:input => 'Fake#gets',
		:output => 'Capture#output'
	} 

	##
	# @!attribute default_input
	# @return [String, Array] the default input if not specified in +WrapIO#of+

	@@default_input = ''

	##
	# @return [Boolean] +true+ if debugging is enabled

	def self.debug
		@@debug
	end

	##
	# Enable or disables debugging
	# @param value [Boolean] +true+ if debugging is enabled

	def self.debug=(value)
		@@debug = value
	end

	##
	# @return [String, Array] the default input if not specified in +WrapIO#of+

	def self.default_input
		@@default_input
	end

	##
	# Set the default input if not specified in +WrapIO#of+
	# @param value [String, Array] the default input if not specified in +WrapIO#of+

	def self.default_input=(value)
		@@default_input = value
	end

	##
	# The main action of the +WrapIO+ module
	# As the semantic reading of the module name and function implies.
	# It wraps the input and output of the given block, making the input
	# passable as a parameter and the output accessible as a return value.
	#
	# @param input [String, Array<String>] the input or array of inputs
	# @yield the block of code from which to wrap I/O
	# @return [String] the captured output from STDOUT

	def self.of(input=nil)
		input = WrapIO.default_input unless input
		Capture.output do
			Fake.input(input) do
				yield
			end
		end
	end

	##
	# Used within module classes to output debug data
	#
	# @param data [String] the string to output
	# @param type [Symbol] the type of data e.g. +:input+ or +:output+
	# @param index [Integer] optionally provide an index of the data

	def self.log(data, type, index=nil)
		puts delimit(data, type, index.to_s)
	end

	private

		##
		# Used internally to mark beginnings and endings of debug logging sections
		#
		# @param data [String] the string to delimit
		# @param type [Symbol] the type of data
		# @param index [Index] a the index of the data

		def self.delimit(data, type, index)
			delimitation = "-- WrapIO %T% %I% --"
			b = delimitation.gsub(/%T%/, @@delimiters[type]).gsub(/%I%/, index)
			c = data
			e = '_' * b.length
			[b, c, e].join("\n")
		end
end
