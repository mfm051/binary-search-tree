# frozen_string_literal: true

require_relative './lib/tree'

tree = Tree.new(Array.new(15) { rand(1..100) })

puts <<~BALANCED
  #{tree}

  Balanced? #{tree.balanced?}

  Preorder: #{tree.preorder}

  Postorder: #{tree.postorder}

  Inorder: #{tree.inorder}

  Level order: #{tree.level_order}

  Unbalancing tree...\n\n\n
BALANCED

(100..105).each { |i| tree.insert(i) }

puts <<~UNBALANCED
  #{tree}

  Still balanced? #{tree.balanced?}

  Rebalancing tree...\n\n\n
UNBALANCED

tree.rebalance

puts <<~REBALANCED
  #{tree}

  Rebalanced? #{tree.balanced?}

  New preorder: #{tree.preorder}

  New postorder: #{tree.postorder}

  New inorder: #{tree.inorder}

  New level order: #{tree.level_order}
REBALANCED
