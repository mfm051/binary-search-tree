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
      it 'returns a balanced binary tree after sorting array and removing its duplicates' do
        messy_data = [2,3,1,1]
        messy_data_tree = tree.build_tree(messy_data)
        expect(messy_data_tree).to be_a_tree
      end
    end
  end
end
