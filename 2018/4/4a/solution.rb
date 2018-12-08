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

sleepest_guard, his_shifts = sleep_shifts_per_guard.max_by { |_id, shifts| shifts.map { |s| s[:minutes_asleep].count }.sum }

id = sleepest_guard

min = his_shifts.flat_map { |x| x[:minutes_asleep] }
  .reduce(Hash.new(0)) { |hash, min| hash[min] += 1; hash }.max_by { |min, count| count }.first

p id.to_i * min
