def next_direction(last)
    case last
    when :right
        :up
    when :up
        :left
    when :left
        :down
    when :down
        :right
    end
end

def move_direction(pos, direction)
    case direction
    when :right
        [pos.first+1, pos.last]
    when :left
        [pos.first-1, pos.last]
    when :up
        [pos.first, pos.last-1]
    when :down
        [pos.first, pos.last+1]
    end
end

input = 12

pos = [0, 0]
direction = :right
num = 1
grid = {  }
while num <= input
    next_direction = next_direction(direction)
    grid[pos] = num
    num += 1
    pos = move_direction(pos, direction)
    if grid[move_direction(pos, next_direction)].nil?
        direction = next_direction
    end
end

ans = grid.select { |pos, num| num == input }
ans_pos = ans.keys.first
ans_num = ans.values.first

p grid
p ans
p ans_pos
p ans_num

answer = ans_pos.first.abs + ans_pos.last.abs
p answer
