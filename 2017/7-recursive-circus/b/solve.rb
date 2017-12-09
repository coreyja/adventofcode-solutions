class Disk
    attr_reader :data, :value, :weight, :children_values

    def initialize(data, value, weight, children_values)
        @data = data
        @value = value
        @weight = weight
        @children_values = children_values
    end

    def parent
		disks.find { |disk| disk.children_values&.include?(value) }
    end

	def balanced?
		children.map(&:total_weight).uniq.count <= 1
	end

	def unbalanced?
		!balanced?
	end

	def total_weight
		weight + children.map(&:total_weight).sum
	end

	def children
		@_children ||= children_values&.map { |child_value| disks.find { |disk| disk.value == child_value } } || []
	end

	def depth
		if parent
			1 + parent.depth
		else
			1
		end
	end

	private

	def disks
		data.map { |value, weight, children| Disk.new(data, value, weight, children) }
	end
end

regex = /^(?<value>\w*) \((?<weight>\d+)\)(?: -> (?<children>.*))?$/
input = File.read('./input.txt')

captures = input.scan(regex)
data = captures.map { |value, weight, children| [value, weight.to_i, children&.split(', ')] }
disks = data.map { |value, weight, children| Disk.new(data, value, weight, children) }

unbalanced = disks.select(&:unbalanced?)
deepest = unbalanced.max_by(&:depth)

children = deepest.children
loner = children.group_by(&:total_weight).select { |weight, group| group.count == 1 }.values.first.first
not_loner = children.group_by(&:total_weight).select { |weight, group| group.count != 1 }.values.first.first

diff = loner.total_weight - not_loner.total_weight

p diff
p loner.weight - diff

