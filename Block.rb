require 'digest'
require 'pp'


class Block
	attr_reader :index, :timestamp, :data, :previous_hash, :hash

	def initialize(index, data, previous_hash)
		@index = index
		@timestamp = Time.now
		@data = data
		@previous_hash = previous_hash
		@hash = compute_hash
	end

	def compute_hash
		sha = Digest::SHA256.new
		sha.update(@index.to_s + @timestamp.to_s + @data.to_s + @previous_hash)
		sha.hexdigest
		p sha
	end

	def self.first(data)
		Block.new(0, data, "0")

	end

	def self.next(previous, data)
		Block.new(previous.index+1, data, previous.hash)
	end


end # class Block

b0 = Block.first("Genesis")
b1 = Block.next(b0, "Second" )
b2 = Block.next(b1, "Third")
b3 = Block.next(b2, "More data")

pp [b0, b1, b2, b3]


