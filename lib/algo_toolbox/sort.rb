require_relative "other_array_methods"

class Array

  # Algorithm:
  # starting with the second element,
  # 1. move the element backwards in the array until the previous element is less than the current element

  def insertion_sort
    (1...self.length).each do |j|
      key = self[j]
      i = j - 1
      while i >= 0 && self[i] > key
        self[i + 1] = self[i]
        i = i - 1
      end
      self[i + 1] = key
    end
    self
  end

  # Algorithm:
  # 1. recursively split the array into left-right pairs until each pair element is length 1
  # 2. recursively merge each left-right pair by shifting the lesser first element into a new array

  def merge_sort
    r = length - 1
    p = (r + 1).divmod(2).sum - 1
    q = p + 1

    if length > 1
      intermediate = []
      left = self[0..p].merge_sort
      right = self[q..r].merge_sort
      until left.length == 0 || right.length == 0
        if left[0] <= right[0]
          intermediate << left.shift
        else
          intermediate << right.shift
        end
      end
      return intermediate.concat(left.concat(right))
    end
    self
  end

  # Algorithm
  # the heap is built based on 1-indexed tree, so shift right to properly index
  # 1. for each node that has child nodes
  # 2. determine the max of the 2-3 node group
  # 3. then move the max node to the parent slot
  # 4. and evaluate 1-3 for the parent of the parent slot
  # this will bubble high numbers to the top
  # and bubble lower numbers to the bottom
  # such that each parent node is >= each child node throughout the whole tree
  # this is called a "max heap" tree
  # 5. then, with the max heap tree, repeat these steps:
  #   1. swap the last element (min) and the first element (max) of the heap
  #   2. pop the last element (max) off the heap
  #   3. bubble the (min) element back to the bottom -> this will bubble the new max to the top
  # this will backwards-fill the array from max to min.

  def heap_sort
    self.unshift(nil)
    left_child = -> i { self[i << 1] }
    right_child = -> i { self[(i << 1) + 1] }
    swap_left = -> i { self.swap!(i, left_child[i]) }
    swap_right = -> i { self.swap!(i, right_child[i]) }
    max_heapify = -> (i, ignore) {
      parent = self[i]
      lc = (i << 1 < ignore) && left_child[i]
      rc = ((i << 1) + 1 < ignore) && right_child[i]
      if lc
        if rc && parent < rc && lc < rc
          swap_right[i]
          max_heapify[((i << 1) + 1), ignore]
        elsif parent < lc
          swap_left[i]
          max_heapify[(i << 1), ignore]
        end
      end
    }
    (self.length / 2).step(1, -1).each do |j|
      max_heapify[j, self.length]
    end
    (self.length - 1).step(2, -1).each do |k|
      self[k], self[1] = self[1], self[k]
      max_heapify[1, k]
    end
    self.shift
    self
  end

  def quicksort(from = 0, to = self.length - 1)
    partition = lambda do
      i, j = from - 1, from
      while j < to
        if self[j] <= self[to]
          i += 1
          swap!(i, j)
        end
        j += 1
      end
      i += 1
      swap!(i, to)
      i
    end
    if from < to
      q = partition.call
      quicksort(from, q - 1)
      quicksort(q + 1, to)
    end
    self
  end
end
