# frozen_string_literal: true

require_relative '../lib/node'

describe Node do
  subject(:node_one) { described_class.new(1) }

  describe '#append' do
    context 'when node to append is greater than self' do
      it 'inserts node as right node' do
        greater_node = Node.new(2)
        node_one.append(greater_node)
        expect(node_one.right).to eq(greater_node)
      end
    end

    context 'when node to append is smaller than self' do
      it 'inserts nodes as left node' do
        smaller_node = Node.new(0)
        node_one.append(smaller_node)
        expect(node_one.left).to eq(smaller_node)
      end
    end

    context 'when node already has a child' do
      subject(:node_with_right_child) { described_class.new(1, right: Node.new(2)) }

      it 'updates child' do
        another_greater_node = Node.new(3)
        node_with_right_child.append(another_greater_node)
        expect(node_with_right_child.right).to eq(another_greater_node)
      end
    end
  end

  describe '#unlink' do
    subject(:node_with_right_child) { described_class.new(1, right: Node.new(2)) }

    context 'when node has child' do
      it 'removes child' do
        right_child = node_with_right_child.right
        node_with_right_child.unlink(right_child)
        expect(node_with_right_child.right).to be_nil
      end
    end

    context 'when node does not have child' do
      it 'does nothing' do
        left_child = Node.new(0)
        expect { node_with_right_child.unlink(left_child) }.not_to(change { node_with_right_child.left })
      end
    end
  end

  describe '#children' do
    subject(:node_with_right_child) { described_class.new(1, right: Node.new(2)) }

    let(:right_child) { node_with_right_child.right }

    it 'returns array with existing children' do
      children = node_with_right_child.children
      expect(children).to be_an(Array).and include right_child
    end
  end
end
