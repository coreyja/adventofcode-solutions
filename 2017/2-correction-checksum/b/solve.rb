def find_divisible(x, array)
    array.find { |a| x % a == 0 }
end

def per_array(array)
    array.map do |x|
        temp = find_divisible(x,array - [x])
        if temp
            x / temp
        end
    end.compact.first
end

input = File.read('./input.txt')

matrix = input.each_line.map(&:split).map { |a| a.map(&:to_i) }

answer = matrix.map { |a| per_array(a) }.sum

print answer

