# frozen_string_literal: true

# Helper methods to divide array in center value and its sides
class Array
  def center_value = slice(middle_index)

  def left_side
    slice(..middle_index - 1).keep_if { |i| i != center_value && i < center_value }
  end

  def right_side
    slice(middle_index + 1..).keep_if { |i| i != center_value && i > center_value }
  end

  private

  def middle_index = (size - 1) / 2
end
