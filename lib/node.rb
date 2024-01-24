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

    self
  end

  def unlink(node)
    @right = nil if @right == node

    @left = nil if @left == node

    node
  end

  def children = [@left, @right].compact

  def switch(other)
    other_data = other.data
    self_data = data

    self.data = other_data
    other.data = self_data

    [self, other].each(&:rearrange)
  end

  def rearrange
    return if @left.nil? || @right.nil?

    left = @left
    right = @right

    return unless @left > @right

    @left = right
    @right = left
  end

  def <=>(other)
    return data <=> other.data if other.is_a? Node

    data <=> other
  end
end
