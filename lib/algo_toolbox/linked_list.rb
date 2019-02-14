LinkedListElement = Struct.new(:value, :next)

class LinkedList
  attr_accessor :head

  def initialize(*args)
    prev = @head = LinkedListElement.new(args.shift)
    until args.empty?
      next_el = LinkedListElement.new(args.shift)
      prev.next = next_el
      prev = next_el
    end
  end

  def add(value)
    prev = @head
    until !prev.next
      prev = prev.next
    end
    prev.next = LinkedListElement.new(value)
    self
  end

  def insert(value)
    @head = LinkedListElement.new(value, @head)
    self
  end

  def search(value)
    prev = @head
    until prev == nil || prev.value == value
      prev = prev.next
    end
  end
end
