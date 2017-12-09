regex = /^(?<register>\w+) (?<direction>\w+) (?<value>-?[\d]+) if (?<con_register>\w+) (?<con_operator>[<>=!]+) (?<con_value>-?\d+)$/
input = File.read('./input.txt')


matches = []
input.scan(regex){ matches << $~ }

registers = Hash.new(0)
max = 0

matches.each do |instruction|
	if eval("#{registers[instruction[:con_register]]} #{instruction[:con_operator]} #{instruction[:con_value]}")
		case instruction[:direction]
		when 'inc'
			registers[instruction[:register]] += instruction[:value].to_i
		when 'dec'
			registers[instruction[:register]] -= instruction[:value].to_i
		end
	end
    max = [max, registers.values.max].max
end

p registers

p registers.values.max
p max
