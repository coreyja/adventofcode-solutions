def basic_opposite(dir)
	case dir
	when 'n'
		's'
	when 's'
		'n'
	when 'e'
		'w'
	when 'w'
		'e'
	end
end

def opposite(dir)
	dir.chars.map do |c|
		basic_opposite(c)
	end.join
end

def next_to(dir)
	if dir.length == 1
		['e','w'].map { |x| dir + x }
	else
		[dir[0], opposite(dir[0]) + dir[1]]
	end
end

def reduce_to(dir, other)
	if dir.length == 2 && other.length == 2
		dir[0]
	else
		two_char = [dir, other].max {|a, b| a.length <=> b.length }
		[opposite(two_char[0]), two_char[1]].join

	end
end

# input = "se,sw,se,sw,sw".split ','
input = File.read('./input.txt').split(',').map(&:strip)

counts = Hash.new(0)
input.each { |x| counts[x] += 1 }

['ne','n','nw'].each do |dir|
	opp_dir = opposite(dir)
	min = [counts[dir], counts[opp_dir]].min
	counts[dir] -= min
	counts[opp_dir] -= min
end

# p 'No More Opposites:'
# p counts


counts.keys.each do |dir|
	possible_reducers = next_to(opposite(dir))
	possible_reducers.each do |possible|
		two_char = [dir, possible].max {|a, b| a.length <=> b.length }
		reduced_to = reduce_to(dir, possible)
		min = [counts[dir], counts[possible]].min
		counts[dir] -= min
		counts[possible] -= min
		counts[reduced_to] += min
	end
end

p counts
p counts.values.sum
