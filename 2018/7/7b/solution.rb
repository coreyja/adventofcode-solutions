# frozen_string_literal: true

require 'set'

INPUT_REGEX = /Step (?<depends_on>\S+) must be finished before step (?<step>\S+) can begin\./.freeze

DELAY = 60.freeze
TIME_FOR_LETTER = ('A'..'Z').each_with_index.reduce({}) { |hash, x| hash[x.first] = x.last + 1 + DELAY; hash }

WORKER_COUNT = 5.freeze

dependencies = Hash.new { |hash, key| hash[key] = Set.new }

File.read("#{__dir__}/../input.txt").each_line do |line|
  match = INPUT_REGEX.match(line).named_captures
  dependencies[match['step']] << match['depends_on']
end

letters_left = Set.new((dependencies.keys + dependencies.values.flat_map(&:to_a)))

def pick_availible(letters_left, dependencies, answer)
  possible = letters_left.to_a.select do |key|
    letters_left.include?(key) && (dependencies[key] - answer).none?
  end

  chosen = possible.min
  letters_left.delete(chosen)

  [chosen, letters_left]
end

answer = []
working_on = Array.new(WORKER_COUNT, [nil, nil])
seconds = -1
while letters_left.any? || working_on.map(&:first).any?
  working_on.map! do |letter, time|
    if letter
      if time >= TIME_FOR_LETTER[letter]
        answer << letter

        [nil, nil]
      else
        [letter, time]
      end
    else
      [nil, nil]
    end
  end

  working_on.map! do |letter, time|
    if letter
      [letter, time + 1]
    else
      chosen, letters_left = pick_availible(letters_left, dependencies, answer)
      [chosen, 1]
    end
  end

  seconds += 1
end

p answer.join
p seconds
