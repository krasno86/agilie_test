class PackHandler
  attr_accessor :processed_elements, :resulted_array, :uniq_by

  def initialize
    @processed_elements = []
    @resulted_array = []
    @uniq_by = ''
  end

  def proc_items arr
    arr.each do |arg|
      next if can_be_processed?(arg)

      self.processed_elements << arg
      self.resulted_array << yield(arg)
    end
  end

  def reset
    self.processed_elements = []
    self.resulted_array = []
    self.uniq_by = ''
  end

  def procd_items
    self.resulted_array
  end

  def identify key
    self.uniq_by = key
  end

  private

  def can_be_processed?(element)
    case
      when element.respond_to?(uniq_by)
        processed_elements.any? { |item| item.send(uniq_by) == element.send(uniq_by) }
      when element.is_a?(Hash)
        processed_elements.any? { |item| item[uniq_by] == element[uniq_by] }
      else
        processed_elements.include?(element)
    end
  end
end

p_h = PackHandler.new
p_h.proc_items([1,2,3]) do |e|
  e
end

p_h.proc_items([3,4,5]) do |e|
  e
end

p p_h.resulted_array
p_h.procd_items
p_h.reset
p_h.identify :id

p_h.proc_items([{id: 1}, {id: 1, test_key: 'Some data'}, {id: 2}]) do |e|
  e
end

p_h.proc_items([{id: 2}, {id: 3}]) do |e|
  e
end

p p_h.resulted_array

p_h.reset
p_h.identify :value


p_h.proc_items([{value: 2}, {value: 3}]) do |e|
  e
end

p p_h.resulted_array

class SomeClass
  attr_accessor :main_field

  def initialize(main_field = nil)
    @main_field = main_field
  end
end

a = SomeClass.new('a')
b = SomeClass.new('b')

p_h1 = PackHandler.new
p_h1.identify :main_field
p_h1.proc_items([a, b]) do |item|
  item
end

p_h1.proc_items([SomeClass.new('a')]) do |item|
  item
end

p p_h1.resulted_array