$uniq_arr = [1,2,3]

class PackHandler
  # class << self
  # attr_accessor​ :elements
  # end

  # @elements = []

  # def ​initialize(elements = [])
  #   @elements = elements
  # end

  def elements=(val=[])
    @elements = val
  end

  def proc_items arr
    arr.each do |e|
      yield(e) unless procd_items.include?(e)
    end
  end

  def reset
    $uniq_arr = []
  end

  def procd_items
    $uniq_arr
  end
end

v = PackHandler.new
v.proc_items([3,4,5]) do |e|
  $uniq_arr << e
end
p v.procd_items