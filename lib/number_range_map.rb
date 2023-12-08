
class NumberRangeMap

  def initialize(dest, src, length)
    @source = NumberRange.new src, length
    @destination = dest
  end

  # rests go to next maps
  # rest after all maps falls through and goes to mapped
  def cut(range)
    return { rest: [], mapped: range.shift_to!(@destination) } if range.inside? @source

    return {
      mapped: @source.clone.shift_to!(@destination),
      rest: [
        NumberRange.new(range.start, @source.start - range.start),
        NumberRange.new(@source.end + 1, range.end - @source.end)
      ]
    } if range.cover?(@source)

    # front
    return {
      mapped: NumberRange.new(@source.start, range.end - @source.start + 1),
      rest: [
        NumberRange.new(range.start, @source.start - range.start)
      ]
    } if @source.include? range.end

    return {
      mapped: NumberRange.new(range.start, @source.end - range.start + 1),
      rest: [
        NumberRange.new(@source.end + 1, range.end - @source.end)
      ]
    } if @source.include? range.start

    { mapped: nil, rest: [range] }
  end
end
