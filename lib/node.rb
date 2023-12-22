class Node
  include Comparable

  attr_reader :data, :left, :right

  def initialize(data, left: nil, right: nil)
    @data = data
    @left = left
    @right = right
  end

  def append(value)
    node = Node.new(value)

    @data < value ? @right = node : @left = node
  end

  def unlink(value)
    @right = nil if @right == value

    @left = nil if @left == value

    value
  end

  def children = [@left, @right].compact

  def <=>(other)
    return data <=> other.data if other.is_a? Node

    data <=> other
  end
end