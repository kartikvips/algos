require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def include?(key)
    hashed = key.hash
    bucket = hashed % @num_buckets
      @store[bucket].include?(key)
    
  end

  def set(key, val)
    resize! if @count >= num_buckets
    hashed = key.hash
    bucket = hashed % @num_buckets
    if @store[bucket].include?(key)
      @store[bucket].update(key,val)
    else
      @store[bucket].append(key,val)
      @count += 1
    end
  end

  def get(key)
    hashed = key.hash
    bucket = hashed % @num_buckets
    @store[bucket].get(key)
    end

  def delete(key)
    hashed = key.hash
    bucket = hashed % @num_buckets
    @store[bucket].remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each { |link| yield [link.key, link.val] }
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
     old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    old_store.each do |bucket|
      bucket.each { |link| set(link.key, link.val) }
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
