
class NumberRangeMap

  def initialize(dest, src, length)
    @source = NumberRange.new src, length
    @destination = dest
  end

  def cut(range)
    return { rest: [], mapped: range.shift_to!(@destination, @source.start) } if range.inside? @source


    if range.cover?(@source)
      mapped = @source.clone.shift_to!(@destination, @source.start)
      rest = []
      rest.push(NumberRange.new(range.start, @source.start - range.start)) if range.start < @source.start
      rest.push(NumberRange.new(@source.end + 1, range.end - @source.end)) if range.end > @source.end

      return {
        mapped: mapped,
        rest: rest
      }
    end

    return {
      mapped: NumberRange.new(@source.start, range.end - @source.start + 1).shift_to!(@destination, @source.start),
      rest: [
        NumberRange.new(range.start, @source.start - range.start)
      ]
    } if @source.include? range.end

    return {
      mapped: NumberRange.new(range.start, @source.end - range.start + 1).shift_to!(@destination, @source.start),
      rest: [
        NumberRange.new(@source.end + 1, range.end - @source.end)
      ]
    } if @source.include? range.start

    { mapped: nil, rest: [range] }
  end

  def new_start(range)
    @destination + (range.start - @source.start).abs
  end

  def to_s
    "From #{@source} to #{@destination}"
  end
end
