DoubleLinkedListElement = Struct.new(:value, :next, :prev)

class DoubleLinkedList
  attr_accessor :head, :circular

  def initialize(*args)
    @head = DoubleLinkedListElement.new(args.shift)
    prev = @head
    until args.empty?
      next_el = DoubleLinkedListElement.new(args.shift, nil, prev)
      prev.next = next_el
      prev = next_el
    end
  end

  def add(value)
    prev = @head
    until !prev.next
      prev = prev.next
    end
    prev.next = DoubleLinkedListElement.new(value, nil, prev)
  end

  def insert(value)
    @head = DoubleLinkedListElement.new(value, @head)
    self
  end

  def search(value)
    prev = @head
    until prev == nil || prev.value == value
      prev = prev.next
    end
    prev
  end

  def delete(value)
    ptr = search(value)
    return self if ptr == nil
    case [!ptr.prev.nil?, !ptr.next.nil?]
    when [false, false]
      nil
    when [true, false]
      ptr.prev.next = nil
    when [true, true]
      ptr.prev.next, ptr.next.prev = ptr.next, ptr.prev
    when [false, true]
      @head = ptr.next
      @head.prev = nil
    end
    self
  end

  def length
    @head ? i = 1 : (return 0)
    until (prev ||= @head).next.nil?
      i += 1
      prev = prev.next
    end
    i
  end
end
