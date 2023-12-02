
# nomnom
NUMNUM = {
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

module Util
  def written_numbers
    NUMNUM.keys.map(&:to_s) or []
  end

  def actual_numbers
    NUMNUM.values.map(&:to_s) or []
  end

  def numbers
    written_numbers + actual_numbers
  end

  def srebmun
    numbers.map { |v| v.chars.reverse.join }
  end

  def map_number(str)
    NUMNUM[str.to_sym]
  end
end

class String
  include Util

  def to_numnum
    map_number(self) || map_number(self.chars.reverse.join) || self.to_i
  end
end

class NilClass
  def values
    []
  end
end
