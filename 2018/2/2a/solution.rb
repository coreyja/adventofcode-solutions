input = File.read('../input.txt').each_line

letter_counts = input.map { |line| line.chars.reduce(Hash.new(0)) { |memo, char| memo[char] += 1; memo } }

num_having_two = letter_counts.select { |line| line.values.include? 2 }.count

num_having_three = letter_counts.select { |line| line.values.include? 3 }.count

puts num_having_two * num_having_three
