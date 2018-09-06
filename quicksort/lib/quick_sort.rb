class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |i, j| i <=> j }

    return array if length < 2

    pivot_idx = partition(array, start, length, &prc)

    leftlen = pivot_idx - start
    rightlen = length - (leftlen + 1)
    sort2!(array, start, leftlen, &prc)
    sort2!(array, pivot_idx + 1, rightlen, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |i, j| i <=> j }

    pivot_idx = start
    pivot = array[start]
    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        array[idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[idx]
        pivot_idx += 1
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]

    pivot_idx
  end
end

