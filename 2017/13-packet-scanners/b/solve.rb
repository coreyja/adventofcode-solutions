class Scanner
	attr_reader :depth

	def initialize(depth)
		@depth = depth
	end

	def position_at(i)
		cycle[i % cycle.count]
	end

	private

	def cycle
		@_cycle ||= ((0..depth-1).to_a + (1..depth-2).to_a.reverse)
	end
end

class Attempt
	def initialize(delay, scanners)
		@delay = delay
		@scanners = scanners
	end

	def costs
		@_costs ||= @scanners.map do |pos, scanner|
			if scanner.position_at(pos + @delay) == 0
				pos * scanner.depth
			else
				0
			end
		end
	end

	def cost
		@_cost ||= costs.sum
	end

	def caught?
		scanner_positions.any? { |pos, scanner_pos| scanner_pos == 0 }
	end

	def scanner_positions
		@_scanner_positions ||= @scanners.map do |pos, scanner|
			[pos, scanner.position_at(pos + @delay)]
		end
	end

	def print
		p "Delay: #{@delay}"
		p "Scanners: #{@scanners}"
		p "Scanner Positions: #{scanner_positions}"
		p "Costs: #{costs}"
	end
end

input = File.read('./input.txt')

start_time = 0

regex = /(\d+): (\d+)/
depths = input.scan(regex).map { |x| x.map(&:to_i) }.to_h
scanners = depths.map { |pos, depth| [pos, Scanner.new(depth)] }.to_h

i = 0
a = Attempt.new(i,scanners)
while a.caught? do
	p i if i % 100 == 0
	i+=1
	a = Attempt.new(i,scanners)
end


p i
a.print
