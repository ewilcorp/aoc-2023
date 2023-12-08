
class Array
  def to_pairs
    self.map.with_index { |v, i| [v, self[i+1].to_i] if i.even? }.compact
  end

  def run
    yield *self
  end

  def clean_ranges
    return self unless self.all? { |r| r.is_a? NumberRange }
    cleaned = []
    while self.length > 0
      popped = self.pop
      cleaned.push(popped) unless self.any? { |any| any.cover? popped } || cleaned.any? { |any| any.cover? popped }
    end
    cleaned
  end
end
