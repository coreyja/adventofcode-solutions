require 'set'

regex = /^(\d+) <-> ((?:\d(?:, )?)*)$/

input = File.read('input.txt')

matches = input.scan(regex)
map = matches.map { |main, pipes_to| [main, pipes_to.split(',').map(&:strip)] }.to_h

visited = Set.new
group = Set.new
to_visit = ['0']

while to_visit.count > 0
	visiting = to_visit.pop
	visited << visiting
	group << visiting
	group += map[visiting]
	to_visit += (map[visiting] - visited.to_a)
end

p map
p group
p group.count

