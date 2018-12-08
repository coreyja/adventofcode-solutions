# frozen_string_literal: true

input = File.read("#{__dir__}/../input.txt").strip.chars

puts 'Starting Length', input.length, ''

def remove_first_opposite_unit(array)
  diff = (0...array.count - 1).each_cons(2).find do |first_i, second_i|
    first = array[first_i]
    second = array[second_i]

    first.casecmp(second).zero? &&
      first != second
  end

  2.times { array.delete_at(diff.first) } if diff
  array
end

current_input = input

loop do
  starting_length = current_input.count
  current_input = remove_first_opposite_unit(current_input)
  ending_length = current_input.count

  break if starting_length == ending_length
end

p current_input.count
