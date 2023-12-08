

NUMBERS_MAP = {
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  nine: 9
}.freeze

KEY_MAPPER = {
  w: ->(k) { k.to_s },
  wr: ->(k) { k.to_s.chars.reverse.join },
  d: ->(k) { NUMBERS_MAP[k.to_sym].to_s }
}

class NumberMapper

  attr_reader :map

  def initialize
    @map = {}
  end

  def []=(k, v)
    self.map[k.to_s] = v.to_i
  end

  def [](k)
    self.map[k.to_s]
  end

  def keys; self.map.keys; end
  def values; self.map.values; end
end

module Numbers
  class << self
    private def included(by)
      if by.eql? String
        KEY_MAPPER.keys.each do |t|
          mapper = NumberMapper.new
          NUMBERS_MAP.keys.each do |k|
            val = NUMBERS_MAP[k]
            mapper[KEY_MAPPER[t].call(k)] = val
            instance_variable_set "@nums_#{t}", mapper
          end
        end
      end
    end
  end

  def numbers_written; Numbers.instance_variable_get "@nums_w"; end
  def numbers_written_reversed; Numbers.instance_variable_get "@nums_wr"; end
  def numbers_digits; Numbers.instance_variable_get "@nums_d"; end

  def to_number
    numbers_written[self] || numbers_digits[self] || numbers_written_reversed[self]
  end
end

class String
  include Numbers

  def is_digit?
    self.ord >= 48 && self.ord <= 57
  end
end

class Integer
  def within?(start, range)
    self >= start && self <= start + range - 1
  end
end

