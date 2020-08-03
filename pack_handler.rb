$uniq_arr = [1,2,3]

class PackHandler
  def key=(val=nil)
    @key = val
  end

  def proc_items arr
    unless @key.nil? && (@key.class == Symbol || String)
      arr.uniq!{|e| e[@key]}
    end

    arr.each do |e|
      yield(e) unless $uniq_arr.include?(e)
    end
  end

  def reset
    $uniq_arr = []
  end

  def procd_items
    $uniq_arr
  end

  def identify arg
    @key = arg
    @key
  end
end

array_of_hashes = [{id: 1}, {id: 1, test_key: 'Some data'}, {id: 2}]
array_of_hashes2 = [{id: 2}, {id: 3}]
v = PackHandler.new
v.proc_items([3,4,5]) do |e|
  $uniq_arr << e
end

p $uniq_arr
v.procd_items
v.reset
v.identify :id

v.proc_items(array_of_hashes) do |e|
  $uniq_arr << e
end

v.proc_items(array_of_hashes2) do |e|
  # if e.class == Hash
  #   array_of_hashes.each{|hash| hash if hash. }
  # end
  # array_of_hashes = array_of_hashes.uniq{|e| e[key]}
  $uniq_arr << e
end

p $uniq_arr