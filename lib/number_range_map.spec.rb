

class NumberRangeMapSpec < Test

  attr_reader :fixture
  def initialize
    @fixture = NumberRangeMap.new(1, 50, 10)
    super
  end

  def test_cut_inside
    in_range = NumberRange.new 50, 10

    self.fixture.cut(in_range).and do |m|
      expect(
        m[:rest].empty?,
        m[:mapped].start.eql?(1),
        m[:mapped].length.eql?(10)
      )
    end
  end

  def test_cut_covers
    in_range = NumberRange.new 45, 25

    self.fixture.cut(in_range).and do |m|
      expect(
        m[:mapped].start.eql?(1),
        m[:mapped].end.eql?(10),
        m[:rest].length.eql?(2),
        m[:rest].first.start.eql?(45),
        m[:rest].first.end.eql?(49),
        m[:rest].last.start.eql?(60),
        m[:rest].last.end.eql?(69)
      )
    end
  end

  def test_cut_front
    in_range = NumberRange.new 40, 15

    self.fixture.cut(in_range).and do |m|
      expect(
        m[:mapped].start.eql?(50),
        m[:mapped].end.eql?(54),
        m[:rest].length.eql?(1),
        m[:rest][0].start.eql?(40),
        m[:rest][0].end.eql?(49)
      )
    end
  end

  def test_cut_back
    in_range = NumberRange.new 55, 15

    self.fixture.cut(in_range).and do |m|
      expect(
        m[:mapped].start.eql?(55),
        m[:mapped].end.eql?(59),
        m[:rest].length.eql?(1),
        m[:rest][0].start.eql?(60),
        m[:rest][0].end.eql?(69)
      )
    end
  end

  def test_cut_no_overlap
    in_range = NumberRange.new 60, 10

    self.fixture.cut(in_range).and do |m|
      expect(
        m[:mapped].nil?,
        m[:rest].length.eql?(1),
        m[:rest][0].eql?(in_range)
      )
    end
  end
end
