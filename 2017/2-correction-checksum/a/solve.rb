input = File.read('./input.txt')

matrix = input.each_line.map(&:split).map { |a| a.map(&:to_i) }

answer = matrix.map { |a| a.max - a.min }.sum

print answer

