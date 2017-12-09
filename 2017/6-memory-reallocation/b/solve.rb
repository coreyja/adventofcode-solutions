def reallocate(memory_bank)
    max = memory_bank.max
    max_index = memory_bank.index(max)

    memory_bank[max_index] = 0
    pos = max_index + 1
    num = max
    while num > 0
        pos %= memory_bank.count
        memory_bank[pos] += 1
        num -= 1
        pos += 1
    end
end

input = File.read('./input.txt')

memory_banks = input.split.map(&:to_i)

visited = Hash.new
index = 0

while visited[memory_banks].nil?
    visited[memory_banks] = index
    reallocate(memory_banks)
    index += 1
end

p index - visited[memory_banks]
