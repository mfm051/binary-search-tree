# frozen_string_literal: true

require_relative 'node'
require_relative 'parts'

# :nodoc:
class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?

    corrected_array = array.uniq.sort

    array_parts = corrected_array.parts

    Node.new(
      array_parts[:center_value],
      left: build_tree(array_parts[:left_side]),
      right: build_tree(array_parts[:right_side])
    )
  end

  def insert(value)
    parent = compare_until_leaf(value) { |node| return nil if node == value }

    parent&.append(value) && to_s
  end

  def delete(value)
    return @root = nil if @root == value

    parent = @root

    until parent.nil?
      child = parent < value ? parent.right : parent.left

      return parent.unlink(value) if child == value

      parent = child
    end

    nil
  end

  def find(value)
    compare_until_leaf(value) { |node| return node if node == value }

    nil
  end

  def level_order(queue = [@root].compact)
    result = []

    until queue.empty?
      current_node = queue.shift

      current_node.children.each { |child| queue << child }

      next yield current_node if block_given?

      result << current_node.data
    end

    result unless block_given?
  end

  def preorder(node = @root, elements = [], &block)
    return if node.nil?

    block_given? ? yield(node) : elements << node.data

    preorder(node.left, elements, &block)
    preorder(node.right, elements, &block)

    elements unless elements.empty?
  end

  def inorder(node = @root, visited = [], &block)
    return if node.nil?

    inorder(node.left, visited, &block)

    block_given? ? yield(node) : visited << node.data

    inorder(node.right, visited, &block)

    visited unless visited.empty?
  end

  def postorder(node = @root, visited = [], &block)
    return if node.nil?

    postorder(node.left, visited, &block)
    postorder(node.right, visited, &block)

    block_given? ? yield(node) : visited << node.data

    visited unless visited.empty?
  end

  def height(value, current_node = find(value))
    return nil if current_node.nil?

    height = 0

    until current_node.children.empty?
      current_node = current_node.children.max { |child| child.children.size }

      height += 1
    end

    height
  end

  def depth(value)
    depth = 0

    compare_until_leaf(value) do |node|
      depth += 1 unless @root == node

      return depth if node == value
    end

    nil
  end

  def balanced?
    preorder do |node|
      height_subtrees_difference = (height(node.left).to_i - height(node.right).to_i).abs

      return false if height_subtrees_difference > 1
    end

    true
  end

  def rebalance
    tree_elements = []

    inorder { |node| tree_elements << node.data }

    @root = build_tree(tree_elements)
  end

  def to_s
    return '' if @root.nil?

    pretty_print
  end

  private

  def compare_until_leaf(value, current_node = @root, &block)
    return if @root.nil? || value.nil?

    yield(current_node) if block_given?

    child = current_node < value ? current_node.right : current_node.left

    return current_node if child.nil?

    compare_until_leaf(value, child, &block)
  end

  # courtesy of a fellow student
  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right

    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"

    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end
end
