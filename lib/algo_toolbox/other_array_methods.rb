class Array
  alias dequeue shift
  alias enqueue <<
  alias head first

  def swap!(index_a, index_b)
    self[index_a], self[index_b] = self[index_b], self[index_a]
    self
  end

  def rest
    a, *b = self
    b
  end

  alias tail rest
end
