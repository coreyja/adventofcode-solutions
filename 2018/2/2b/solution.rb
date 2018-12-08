input = File.read('../input.txt').each_line

char_arrays = input.map(&:chars)

def has_one_difference?(a1, a2)
  differences = 0
  a1.each_with_index do |a1x, i|
    differences += 1 if a1x != a2[i]
    return false if differences > 1
  end
  if differences == 1
    return true
  else
    return false
  end
end

pair = char_arrays.product(char_arrays).find { |a1, a2| has_one_difference?(a1, a2) }

p pair.map(&:join)
