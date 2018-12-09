# frozen_string_literal: true

require 'set'

input = File.read("#{__dir__}/../input.txt").each_line.to_a

coordinates = input.map { |x| x.split(',').map(&:strip).map(&:to_i) }

lowest_x = coordinates.min_by(&:first).first
highest_x = coordinates.max_by(&:first).first
lowest_y = coordinates.min_by(&:last).last
highest_y = coordinates.max_by(&:last).last

grid = {}

def closest_coordinate_to(x, y, coordinates)
  distances = coordinates.map do |coor_x, coor_y|
    [(x - coor_x).abs + (y - coor_y).abs, [coor_x, coor_y]]
  end.sort

  max_distance = distances.first.first
  distances.first.last unless max_distance == distances[1].first
end

(lowest_x..highest_x).each do |x|
  (lowest_y..highest_y).each do |y|
    grid[[x, y]] = closest_coordinate_to(x, y, coordinates)
  end
end

counts_per_coord = Hash.new(0)
grid.each do |_k, v|
  counts_per_coord[v] += 1
end

on_edge = Set.new
(lowest_x..highest_x).each do |x|
  (lowest_y..highest_y).each do |y|
    if lowest_x == x || lowest_y == y ||
       highest_x == x || highest_y == y
      on_edge << grid[[x, y]]
    end
  end
end

count_per_eligible = counts_per_coord.reject { |k, _| on_edge.include?(k) }

p count_per_eligible.values.max
