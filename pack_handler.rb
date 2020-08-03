class PackHandler
  attr_accessor :arr, :key

  def initialize(arr = [], key = nil)
    @arr = arr
    @key = key
  end

  def proc_items args
    unless @key.nil? && (@key.class == Symbol || String)
      args.uniq!{|e| e[@key]}
    end

    args.each do |e|
      yield(e) unless self.arr.include?(e)
    end
  end

  def reset
    self.arr = []
  end

  def procd_items
    self.arr
  end

  def identify arg
    self.key = arg
  end
end

v = PackHandler.new([1,2,3])
v.proc_items([3,4,5]) do |e|
  v.arr << e
end

p v.arr
v.procd_items
v.reset
v.identify :id

v.proc_items([{id: 1}, {id: 1, test_key: 'Some data'}, {id: 2}]) do |e|
  v.arr << e
end

v.proc_items([{id: 2}, {id: 3}]) do |e|
  v.arr << e
end

p v.arr

v.reset
v.identify :value

v.proc_items([{value: 2}, {value: 3}]) do |e|
  v.arr << e if e[v.key] % 2 == 0
end

p v.arr