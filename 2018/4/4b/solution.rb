# frozen_string_literal: true

require 'time'

input = File.read("#{__dir__}/../input.txt").each_line

LINE_REGEX = /^\[(?<time>.*)\] (?<message>.*)$/.freeze
lines = input.map do |line|
  match = LINE_REGEX.match(line).named_captures
  { timestamp: Time.parse(match['time']), message: match['message'] }
end

lines.sort_by! { |line| line[:timestamp] }

current_guard = nil
asleep_since = nil

sleep_shifts = []

GUARD_REGEX = /Guard #(\d+) begins shift/.freeze
lines.each do |line|
  message = line[:message]
  timestamp = line[:timestamp]

  if message.match?(GUARD_REGEX)
    current_guard = message.match(GUARD_REGEX)[1]
  elsif message == 'falls asleep'
    asleep_since = timestamp
  elsif message == 'wakes up'
    minutes = (asleep_since.min...timestamp.min).to_a
    sleep_shifts << { id: current_guard, minutes_asleep: minutes }

    asleep_since = nil
  else
    raise "unknown line #{message}"
  end
end

sleep_shifts_per_guard = sleep_shifts.group_by { |x| x[:id] }

guards_and_min_sleep_counts = sleep_shifts_per_guard.map do |id, shifts|
  [
    id,
    shifts.flat_map { |x| x[:minutes_asleep] }.reduce(Hash.new(0)) { |hash, min| hash[min] += 1; hash }
  ]
end.to_h

chosen_guard = guards_and_min_sleep_counts.max_by { |_, mins| mins.values.max }

id = chosen_guard.first
chosen_min = chosen_guard.last.max_by(&:last).first

p id, chosen_min
p id.to_i*chosen_min
