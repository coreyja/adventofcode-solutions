require 'set'

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
	if opposite(dir) == other
		nil
	elsif dir.length == 2 && other.length == 2
		dir[0]
	else
		two_char = [dir, other].max {|a, b| a.length <=> b.length }
		[opposite(two_char[0]), two_char[1]].join
	end
end

def min_steps(input)
	Hash.new(0).tap do |counts|
		input.each { |x| counts[x] += 1 }

		counts.keys.each do |dir|
			possible_reducers = [opposite(dir)] + next_to(opposite(dir))
			possible_reducers.each do |possible|
				reduced_to = reduce_to(dir, possible)
				min = [counts[dir], counts[possible]].min
				counts[dir] -= min
				counts[possible] -= min
				counts[reduced_to] += min if reduced_to
			end
		end
	end.values.sum
end

# input = "se,sw,se,sw,sw".split ','
input = File.read('./input.txt').split(',').map(&:strip)

# counts = min_steps(input)

ans = input.each_index.map do |i|
	min_steps(input[0..i])
end.max

p ans
