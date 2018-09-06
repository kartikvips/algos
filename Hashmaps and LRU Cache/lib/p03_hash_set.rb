class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    resize! if count == @num_buckets
    hashed = key.hash
    bucket = hashed % @num_buckets

    unless @store[bucket].include?(key)
      @store[bucket] << key
      @count += 1
    end
    

  end

  def include?(key)
    hashed = key.hash
    bucket = hashed % @num_buckets

    @store[bucket].include?(key)
  end

  def remove(key)
    hashed = key.hash
    bucket = hashed % @num_buckets

    if @store[bucket].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    oldstore = @store
    @store = Array.new(@count * 2) { Array.new }
    # p @store
    @num_buckets *= 2
    oldstore.each do |bucket|
      bucket.each do |el|
        bucketer = el % @num_buckets
        @store[bucketer] << el
      end
    end
  end
end
