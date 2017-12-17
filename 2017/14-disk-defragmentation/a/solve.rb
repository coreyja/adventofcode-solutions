class CircularArray < Array
	def [](index)
		super(index % count)
	end

	def []=(index, value)
		super(index % count, value)
	end

	def reverse(starting_pos, length)
		ending_pos = starting_pos + length - 1
		num_to_swap = (length / 2.0).ceil
		(0..num_to_swap-1).each do |i|
			swap(starting_pos + i, ending_pos - i)
		end
	end

	private

	def swap(x ,y)
		self[x], self[y] = self[y], self[x]
	end
end

class KnotHash
	def initialize(input)
		@input = input
	end

	def lengths
		@_lengths = @input.strip.chars.map(&:ord) + [17, 31, 73, 47, 23]
	end

	def sparse_hash
		unless defined?(@_sparse_hash)
			list = CircularArray.new((0..255).to_a)
			cur_pos = 0
			skip_size = 0

			64.times do
				lengths.each do |length|
					list.reverse(cur_pos, length)
					cur_pos += length + skip_size
					skip_size += 1
				end
			end
			@_sparse_hash = list.to_a
		end
		@_sparse_hash
	end

	def grouped_hash
		@_grouped_hash ||= (0..15).map { |i| sparse_hash[i * 16, 16] }
	end

	def dense_hash
		@_dense_hash ||= grouped_hash.map { |array| array.reduce(0) { |ans, x| ans ^= x } }
	end

	def hash
		@_hash ||= dense_hash.map { |x| "%02x" % x }.join
	end

    def binary
        @_binary ||= dense_hash.map { |x| "%08b" % x }.join
    end
end

input = File.read('./input.txt')

row_inputs = (0..127).map do |i|
    "#{input}-#{i}"
end

hashed_rows = row_inputs.map do |row|
	KnotHash.new(row).binary
end

ans = hashed_rows.map do |row|
	row.chars.map(&:to_i).sum
end.sum

p ans
