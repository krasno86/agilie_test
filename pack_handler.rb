UNIQ_ARRAY = [1,2,3]

class PackHandler
  # class << self
  #   attr_accessor​ :elements
  # end

  @elements = []

  # def ​initialize()
  # end

  def proc_items arr
    arr.each do |e|
      yield(e) unless UNIQ_ARRAY.include?(e)
    end
  end

  # def reset
  #   UNIQ_ARRAY = []
  # end
end

v = PackHandler.new
v.proc_items([3,4,5]) do |e|
  UNIQ_ARRAY << e
end
p UNIQ_ARRAY