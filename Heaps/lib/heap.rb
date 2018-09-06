require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |i, j| i <=> j }
  end

  def count
    store.length
  end

  def extract
    val = store[0]

    if count > 1
      store[0] = store.pop
      self.class.heapify_down(store, 0, &prc)
    else
      store.pop
    end

    val
  end

  def peek
    store[0]
  end

  def push(val)
    store << val
    self.class.heapify_up(store, self.count - 1, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    child1 = 2 * parent_index + 1
    child2 = 2 * parent_index + 2

    
    [child1, child2].select { |i| i < len }
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1)/2

  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    children = child_indices(len, parent_idx) || []
    first_child, second_child = children
    children = children.map { |idx| array[idx] }

    return array if children.all? { |child| prc.call(array[parent_idx], child) <= 0 }

    smaller_idx = first_child
    unless children.length == 1
      smaller_idx =
        prc.call(children[0], children[1]) == -1 ? first_child : second_child
    end

    array[parent_idx], array[smaller_idx] = array[smaller_idx], array[parent_idx]
    heapify_down(array, smaller_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |i, j| i <=> j }

    return array if child_idx == 0

    parent_idx = parent_index(child_idx)
    child_val, parent_val = array[child_idx], array[parent_idx]
    if prc.call(child_val, parent_val) >= 0
      return array
    else
      array[child_idx], array[parent_idx] = parent_val, child_val
      heapify_up(array, parent_idx, len, &prc)
    end
  end
end
