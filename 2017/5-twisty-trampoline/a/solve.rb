input = File.read('./input.txt')

instructions = input.each_line.map(&:to_i)
pos = 0
jumps = 0

while pos >=0 && pos < instructions.count do
    next_pos = pos + instructions[pos]
    instructions[pos] += 1
    pos = next_pos
    jumps += 1
end

print jumps




