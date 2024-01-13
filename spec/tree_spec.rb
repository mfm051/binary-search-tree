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

  describe '#level_order' do
    subject(:tree_letters) { described_class.new(['a','b','c']) }

    context 'without block' do
      it 'returns array with tree values in level order' do
        values = tree_letters.level_order
        expect(values).to eq(['b','a','c'])
      end
    end

    context 'with block' do
      it 'yields each node in level order' do
        values_upcase = []
        tree_letters.level_order { |node| values_upcase << node.data.upcase }
        expect(values_upcase).to eq(['B','A','C'])
      end
    end
  end

  describe '#inorder' do
    subject(:tree_many_letters) { described_class.new(%w[a b c d e]) }

    context 'without block' do
      it 'returns array with tree values inorder' do
        values = tree_many_letters.inorder
        expect(values).to eq(%w[a b c d e])
      end
    end

    context 'with block' do
      it 'yields each node in level order' do
        values_upcase = []
        tree_many_letters.inorder { |node| values_upcase << node.data.upcase }
        expect(values_upcase).to eq(%w[A B C D E])
      end
    end
  end

  describe '#preorder' do
    subject(:tree_many_letters) { described_class.new(%w[a b c d e]) }

    context 'without block' do
      it 'returns array with tree values preorder' do
        values = tree_many_letters.preorder
        expect(values).to eq(%w[c a b d e])
      end
    end

    context 'with block' do
      it 'yields each node in level order' do
        values_upcase = []
        tree_many_letters.preorder { |node| values_upcase << node.data.upcase }
        expect(values_upcase).to eq(%w[C A B D E])
      end
    end
  end

  describe '#postorder' do
    subject(:tree_many_letters) { described_class.new(%w[a b c d e]) }

    context 'without block' do
      it 'returns array with tree values preorder' do
        values = tree_many_letters.postorder
        expect(values).to eq(%w[b a e d c])
      end
    end

    context 'with block' do
      it 'yields each node in level order' do
        values_upcase = []
        tree_many_letters.postorder { |node| values_upcase << node.data.upcase }
        expect(values_upcase).to eq(%w[B A E D C])
      end
    end
  end
end
