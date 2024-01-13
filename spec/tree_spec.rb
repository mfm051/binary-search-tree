# frozen_string_literal: true

require_relative '../lib/tree'
require_relative '../lib/node'

describe Tree do
  subject(:tree) { described_class.new([1,2,3]) }

  matcher :be_a_tree do
    correct_order = lambda { |node| (node.left.nil? || node.left < node) && (node.right.nil? || node < node.right) }

    match { |root| correct_order.call(root) && correct_order.call(root.left) && correct_order.call(root.right) }
  end

  describe '#build_tree' do
    context 'when array is sorted and has no duplicates' do
      it 'returns a balanced binary tree' do
        data = [1,2,3]
        data_tree = tree.build_tree(data)
        expect(data_tree).to be_a_tree
      end
    end

    context 'when array is not sorted and has duplicates' do
      it 'returns a balanced binary tree with corrected array' do
        messy_data = [2,3,1,1]
        messy_data_tree = tree.build_tree(messy_data)
        expect(messy_data_tree).to be_a_tree
      end
    end
  end

  describe '#insert' do
    pending
  end

  describe '#delete' do
    pending
  end

  describe '#find' do
    subject(:tree_with_1) { described_class.new([1]) }

    context 'when value is present' do
      it 'returns node' do
        node_1 = tree_with_1.find(1)
        expect(node_1).to be_a(Node)
      end
    end

    context 'when value is not present' do
      it 'returns nil' do
        node_2 = tree_with_1.find(2)
        expect(node_2).to be_nil
      end
    end
  end
end
