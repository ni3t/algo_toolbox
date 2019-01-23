class Array
  def swap!(index_a, index_b)
    self[index_a], self[index_b] = self[index_b], self[index_a]
    self
  end
end
