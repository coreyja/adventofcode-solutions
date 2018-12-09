# frozen_string_literal: true

require 'set'

INPUT_REGEX = /Step (?<depends_on>\S+) must be finished before step (?<step>\S+) can begin\./.freeze

dependencies = Hash.new { |hash, key| hash[key] = Set.new }

File.read("#{__dir__}/../input.txt").each_line do |line|
  match = INPUT_REGEX.match(line).named_captures
  dependencies[match['step']] << match['depends_on']
end

p dependencies

letters_left = Set.new((dependencies.keys + dependencies.values.flat_map(&:to_a)))
answer = []
while letters_left.any?
  possible = letters_left.to_a.select do |key|
    letters_left.include?(key) && (dependencies[key] - answer).none?
  end

  chosen = possible.min
  answer << chosen
  letters_left.delete(chosen)
end

p answer.join
