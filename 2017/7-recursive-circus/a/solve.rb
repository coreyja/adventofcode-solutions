def parent(data, x)
	data.find { |value, weight, children| children&.include?(x) }
end

regex = /^(?<value>\w*) \((?<weight>\d+)\)(?: -> (?<children>.*))?$/
input = File.read('./input.txt')

captures = input.scan(regex)

data = captures.map { |value, weight, children| [value, weight, children&.split(', ')] }

x = data.sample.first
until parent(data, x).nil? do
	x = parent(data, x).first
end

p x
