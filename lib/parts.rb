class Array
  def parts
    middle_index = (size - 1) / 2

    center_value = slice(middle_index)

    left_side = slice(..middle_index - 1).keep_if { |i| i != center_value && i < center_value }

    right_side = slice(middle_index + 1..).keep_if { |i| i != center_value && i > center_value }

    { center_value: center_value, left_side: left_side, right_side: right_side }
  end
end
