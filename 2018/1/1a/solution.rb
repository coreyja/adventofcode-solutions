input = File.read('../input.txt').each_line.map(&:to_i)

puts input.reduce(0, :+)

