class CircularArray < Array
    def [](index)
        super(index % count)
    end

    def []=(index, value)
        super(index % count, value)
    end

    def reverse(starting_pos, length)
        ending_pos = starting_pos + length - 1
        num_to_swap = (length / 2.0).ceil
        (0..num_to_swap-1).each do |i|
            swap(starting_pos + i, ending_pos - i)
        end
    end

    private

    def swap(x ,y)
        self[x], self[y] = self[y], self[x]
    end
end

list = CircularArray.new((0..255).to_a)


input = File.read('./input.txt')
lengths = input.split(',').map(&:to_i)

cur_pos = 0
skip_size = 0

lengths.each do |length|
    # p list
    list.reverse(cur_pos, length)
    cur_pos += length + skip_size
    skip_size += 1
end

 p list
 p list[0] * list[1]
