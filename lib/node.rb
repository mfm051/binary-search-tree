# frozen_string_literal: true

# :nodoc:
class Node
  include Comparable

  attr_accessor :data
  attr_reader :left, :right

  def initialize(data, left: nil, right: nil)
    @data = data
    @left = left
    @right = right
  end

  def append(node)
    self < node ? @right = node : @left = node
  end

  def unlink(value)
    @right = nil if @right == value

    @left = nil if @left == value

    value
  end

  def children = [@left, @right].compact

  def switch(other)
    other_data = other.data
    self_data = data

    self.data = other_data
    other.data = self_data
  end

  def <=>(other)
    return data <=> other.data if other.is_a? Node

    data <=> other
  end
end
