require_relative "other_array_methods"

# A priority queue is a data structure for maintaining a set S of elements,
# each with an associated value called a key.

class AlgoToolbox::PriorityQueue
  # @!attribute queue
  #   @return [Array] The priority queue
  # @!attribute type
  #   @return [Symbol] Either +:min+ or +:max+
  attr_accessor :queue, :type

  #
  # Initialize the Priority Queue
  #
  # @param [Array] queue <description>
  # @param [Symbol] type <description>
  #
  def initialize(queue = [], type = :max)
    @queue = queue
    @type = type
  end

  #
  # Insert one or more values into the priority queue.
  #
  # @param [Integer] *values <description>
  #
  # @return [PriorityQueue] <description>
  #
  def insert(*values)
    values.map do |value|
      op = type == :max ? :- : :+
      queue << (queue.min || value).send(op, 1)
      update_key(queue.length - 1, value)
    end
    return self
  end

  #
  # Returns the next queue item, without extracting it.
  #
  # @return [Integer] The next item from the queue
  #
  def maximum
    queue[0]
  end

  #
  # Returns the next queue item, removing it from the queue, and re-sorts the queue
  #
  # @return [Integer] The next item from the queue.
  #
  def extract
    raise "Queue Underflow" if queue.length == 0
    max = queue.shift
    queue.unshift(queue.pop).compact!
    self.heapify(0)
    queue.shift
    return max
  end

  #
  # Updates a key in the queue, by queue index.
  #
  # @param [Integer] index <description>
  # @param [any] value <description>
  #
  # @return [<Type>] <description>
  #
  def update_key(index = -1, value)
    op = type == :max ? :< : :>
    raise "Invalid update, value must not be #{op} than current value" if value.send(op, queue[index])
    if value < queue[index]
      queue[index] = value
      return self
    end
    queue[index] = value
    while index > 0 && queue[index >> 1] < value
      queue.swap!(index >> 1, index)
      index = index >> 1
    end
    return self
  end

  private

  def heapify(index)
    queue.unshift(nil)
    index = 1 if index == 0
    left_child = queue[index << 1]
    right_child = queue[index << 1 ^ 1]
    parent = queue[index]
    op = type == :max ? :< : :>
    if left_child
      if right_child && parent.send(op, right_child) && left_child.send(op, right_child)
        queue.swap!(index << 1 ^ 1, index).shift
        self.heapify(index << 1 ^ 1)
      elsif parent.send(op, left_child)
        queue.swap!(index << 1, index).shift
        self.heapify(index << 1)
      end
    end
    return self
  end
end
