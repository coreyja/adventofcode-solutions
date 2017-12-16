class Scanner
	attr_reader :depth

	def initialize(depth)
		@depth = depth
	end

	def position_at(i)
		cycle.cycle.each_with_index.find { |x, y| y == i }.first
	end

	private

	def cycle
		((0..depth-1).to_a + (1..depth-2).to_a.reverse)
	end
end

input = File.read('./input.txt')

start_time = 0

regex = /(\d+): (\d+)/
depths = input.scan(regex).map { |x| x.map(&:to_i) }.to_h
scanners = depths.map { |pos, depth| [pos, Scanner.new(depth)] }

costs = scanners.map do |pos, scanner|
	if scanner.position_at(pos + start_time) == 0
		pos * scanner.depth
	else
		0
	end
end

p costs.sum
