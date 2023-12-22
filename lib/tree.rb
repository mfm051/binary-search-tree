require_relative 'node'
require_relative 'parts'

class Tree
  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?

    parts = array.parts

    Node.new(
      parts[:center_value],
      left: build_tree(parts[:left_side]),
      right: build_tree(parts[:right_side])
    )
  end

  def insert(value, parent = @root)
    return nil if parent == value

    child = parent < value ? parent.right : parent.left

    return insert(value, child) unless child.nil?

    parent.append(value)

    to_s
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

  def find(value)
    current = @root

    until current.nil?
      return current if current == value

      next_node = current < value ? current.right : current.left

      current = next_node
    end

    nil
  end

  def to_s
    return '' if @root.nil?

    pretty_print
  end

  private

  # courtesy of a fellow student
  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right

    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"

    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end
end
