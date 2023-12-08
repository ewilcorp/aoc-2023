class NumberRangeSpec < Test
    def test_shift_to
    fixture = NumberRange.new 10, 5
    fixture.shift_to! 5
    fixture.start.eql?(5) and fixture.end.eql?(9) and fixture.length.eql?(5)
  end

  def test_inside
    fixture = NumberRange.new 10, 6 # 10-15

    [fixture,
     NumberRange.new(10, 7),
     NumberRange.new(9, 7),
     NumberRange.new(5, 25)
    ].all? do |other|
      fixture.inside? other
    end
  end

  def test_cover
    fixture = NumberRange.new 10, 6 # 10-15

    [fixture, NumberRange.new(10, 5), NumberRange.new(11, 5)].all? do |other|
      fixture.cover? other
    end
  end

  def test_start
    NumberRange.new(10, 2).start.eql? 10
  end

  def test_end
    NumberRange.new(10, 5).end.eql? 14
  end

  def test_length
    NumberRange.new(10, 5).length.eql? 5
  end
end
