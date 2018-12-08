input = File.read('../input.txt').each_line.map(&:to_i)

hash = Hash.new(0)
count = 0
input.cycle.each do |x|
  count += x
  hash[count] += 1
  if hash[count] != 1
    puts count
    exit
  end
end
