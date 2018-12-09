# frozen_string_literal: true

require 'set'

input = File.read("#{__dir__}/../input.txt").each_line.to_a

coordinates = input.map { |x| x.split(',').map(&:strip).map(&:to_i) }

lowest_x = coordinates.min_by(&:first).first
highest_x = coordinates.max_by(&:first).first
lowest_y = coordinates.min_by(&:last).last
highest_y = coordinates.max_by(&:last).last

grid = {}

def sum_of_distances(x, y, coordinates)
  coordinates.sum do |coor_x, coor_y|
    (x - coor_x).abs + (y - coor_y).abs
  end
end

(lowest_x..highest_x).each do |x|
  (lowest_y..highest_y).each do |y|
    grid[[x, y]] = sum_of_distances(x, y, coordinates)
  end
end

p grid.select { |_k, v| v < 10_000 }.count
