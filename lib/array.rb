
class Array
  def to_pairs
    self.map.with_index { |v, i| [v, self[i+1].to_i] if i.even? }.compact
  end

  def run
    yield *self
  end
end
