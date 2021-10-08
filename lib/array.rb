class Array
  def four_items_same_value_continous?
    count_two_items_in_front_same_value = 0
    each_with_index do |item, index|
      count_two_items_in_front_same_value += 1 if item && item == self[index + 1] && item == self[index + 2]
    end
    count_two_items_in_front_same_value == 2
  end
end
