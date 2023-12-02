# frozen_string_literal: true

class String
  def parse_calibration_1
    self.chars.map { |s| Integer s rescue nil }.compact.values_at(0, -1).rotate.map.with_index { |v, i| v * 10.pow(i) }.sum
  end

  def parse_calibration_2
    a = self.parse_first_target(numbers).to_numnum
    b = self.chars.reverse.join.parse_first_target(srebmun).to_numnum
    "#{a}#{b}".to_i
  end

  def parse_first_target(targets)
    targets
      .map(&:to_s)
      .map {|v| {self.index(v) => v} }
      .delete_if { |v| v.keys.compact.length == 0 }
      .reduce {|memo, v| v.keys[0] < memo.keys[0] ? v : memo }
      .values
      .pop
  end
end
