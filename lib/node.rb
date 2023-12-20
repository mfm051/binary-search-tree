class Node
  include Comparable

  attr_reader :data
  attr_accessor :left, :right

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  def <=>(other)
    data <=> other.data
  end
end
