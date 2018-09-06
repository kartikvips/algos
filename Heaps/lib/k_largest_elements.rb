require_relative 'heap'

def k_largest_elements(array, k)
    res = []
    heap = BinaryMinHeap.new()

    array.each do |el|
        heap.push(el)
    end
    
    
    while(k > 0)
        res << heap.extract
        k -= 1
    end
    res
end
