def find_divisible(x, array)
    array.find { |a| x % a == 0 }
end

def per_array(array)
    array.each_with_index.map do |x, i|
        temp = find_divisible(x,array - [x])
        x / temp if temp
    end.compact.first
end

input = File.read('./input.txt')

matrix = input.each_line.map(&:split).map { |a| a.map(&:to_i) }

answer = matrix.map { |a| per_array(a) }.sum

print answer

