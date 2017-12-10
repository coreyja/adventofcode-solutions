class Group
	attr_reader :items, :parent, :garbage_count, :other_garbage

	def initialize(string, parent=nil)
		@parent = parent
		match = /^{(.*)}$/.match(string)
		raise "#{string} is not a valid group score #{score}" if match.nil?

		open_count = 0
		@items = []
        @garbage_count = 0
		last_index = 0
		chars = match[1].chars
		cleaning_started = false
		i = 0
		while i < chars.count do
			c = chars[i]
			if cleaning_started
				if c == '!'
					@garbage_count -= 2
					i += 2
					next
				end
				if c == '>'
					@garbage_count += (i - cleaning_started - 1)
					cleaning_started = false
					next
				end
			else
				if c == '<'
					cleaning_started = i
					next
				end
				if c == '{' && open_count == 0
					last_index = i
				end
				open_count += 1 if c == '{'
				open_count -= 1 if c == '}'
				if c == '}' && open_count == 0
					@items << Group.new(chars[last_index..i].join, self)
				end
			end
			i += 1
		end
	end

	def score
		[1, parent&.score].compact.sum
	end

	def all_groups
		[self] + items.flat_map(&:all_groups)
	end
end

input = File.read('./input.txt')
# cleaned = input.gsub(/[^!]!./, '').gsub(/<(?:[^!]|!!)>/, '')
# input = "{<!!!>>}"
# p input
# cleaned = input.gsub(/<(?:[^!]|!!)>/, '')

# raise cleaned if cleaned.include?('>') || cleaned.include?('<')


g = Group.new(input)

groups = g.all_groups


p groups.map(&:score).sum
p g.garbage_count





