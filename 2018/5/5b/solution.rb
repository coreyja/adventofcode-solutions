# frozen_string_literal: true

input = File.read("#{__dir__}/../input.txt").strip

puts 'Starting Length', input.length, ''

def remove_opposite_units(input)
  uniq_units = input.downcase.chars.uniq

  current = input
  uniq_units.each do |unit|
    current = current.gsub(/#{unit}#{unit.upcase}/, '')
    current = current.gsub(/#{unit.upcase}#{unit}/, '')
  end
  current
end

def make_as_short_as_possible(input)
  current_input = input

  loop do
    starting_length = current_input.length
    current_input = remove_opposite_units(current_input)
    ending_length = current_input.length

    break if starting_length == ending_length
  end

  current_input
end


uniq_units = input.downcase.chars.uniq

p uniq_units

foo = {}
uniq_units.each do |unit|
  new_input = input.gsub(/[#{unit}#{unit.upcase}]/,'')
  p "Starting #{unit}"
  foo[unit] = make_as_short_as_possible(new_input)
end

bar = foo.map { |k, v| [k, v.length] }

puts(bar.min_by { |key, value| value })
