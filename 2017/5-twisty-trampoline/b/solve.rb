input = File.read('./input.txt')

instructions = input.each_line.map(&:to_i)
pos = 0
jumps = 0

while pos >=0 && pos < instructions.count do
    next_pos = pos + instructions[pos]
    if instructions[pos] >= 3
        instructions[pos] -= 1
    else
        instructions[pos] += 1
    end
    pos = next_pos
    jumps += 1
end

print jumps




