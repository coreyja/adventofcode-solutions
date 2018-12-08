# frozen_string_literal: true

input = File.read("#{__dir__}/../input.txt").each_line

regex = /^#(?<id>\d+) @ (?<start_x>\d+),(?<start_y>\d+): (?<size_x>\d+)x(?<size_y>\d+)$/
parsed_inputs = input.map do |line|
  match = regex.match(line)
  match.named_captures
end

claims = Hash.new { |hash, key| hash[key] = [] }

parsed_inputs.each do |request|
  (0...request['size_x'].to_i).each do |x|
    (0...request['size_y'].to_i).each do |y|
      point = [x+request['start_x'].to_i, y+request['start_y'].to_i]
      claims[point] << request['id']
    end
  end
end

puts claims.count
puts claims.values.select { |claims| claims.count >= 2 }.count
