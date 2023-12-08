class NumberRange

  attr_reader :range

  def initialize(start, length)
    self.init(start, length)
  end

  def shift_to!(start)
    self.init(start, self.length)
    self
  end

  def cover?(other)
    return self.cover? other.range if other.is_a? NumberRange
    self.range.cover? other
  end

  def inside?(other)
    other.cover? self
  end

  def overlap_front?(other)
    self.range.include? other.end
  end

  def overlap_back?(other)
    self.range.include? other.start
  end

  def start
    self.range.min
  end

  def end
    self.range.max
  end

  def length
    self.range.size
  end

  def to_range
    self.range
  end
  def to_s
    [self.start, self.end, self.length].to_s
  end

  def each
    self.length.times do |step|
      yield self.start + step
    end
  end

  private def init(start, length)
    @range = (start...start + length)
  end

  private def method_missing(symbol, *args)
    @range.send(symbol, *args) if @range.respond_to? symbol
  end

  # @deprecated
  def overlap?(range)
    return false if range.nil?
    s = (range.start >= self.start && range.start <= self.end)
    e = (range.end >= self.start && range.end <= self.end)
    a = (range.start <= self.start && range.end >= self.end)
    s || e || a
  end
end
