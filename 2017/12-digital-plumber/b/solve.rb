require 'set'

def group_for(map, x)
visited = Set.new
group = Set.new
to_visit = [x]

while to_visit.count > 0
	visiting = to_visit.pop
	visited << visiting
	group << visiting
	group += map[visiting]
	to_visit += (map[visiting] - visited.to_a)
end
group
end

regex = /^(\d+) <-> ((?:\d(?:, )?)*)$/

input = File.read('input.txt')

matches = input.scan(regex)
map = matches.map { |main, pipes_to| [main, pipes_to.split(',').map(&:strip)] }.to_h

keys = Set.new map.keys
groups = []

while (to_visit = keys - groups.reduce(Set.new, &:+)).count > 0
	visiting = to_visit.to_a.pop
	groups << group_for(map, visiting)
end

p groups
p groups.count

